param(
  [Parameter(Mandatory = $true)]
  [string]$WorkspacePath,

  [Parameter(Mandatory = $true)]
  [string]$OutJson,

  [Parameter(Mandatory = $true)]
  [string]$OutMarkdown

  ,
  [Parameter(Mandatory = $false)]
  [string]$OutTranscript
)

$ErrorActionPreference = "Stop"

function Get-AnonymousId {
  param([string]$Text)
  if (-not $Text) { return "anon-000000000000" }
  $sha = [System.Security.Cryptography.SHA256]::Create()
  try {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text.ToLower())
    $hash = $sha.ComputeHash($bytes)
  }
  finally {
    $sha.Dispose()
  }
  $hex = -join ($hash | ForEach-Object { $_.ToString("x2") })
  return "anon-" + $hex.Substring(0, 12)
}

$anonymousId = Get-AnonymousId -Text $WorkspacePath

function Normalize-PathString {
  param([string]$PathText)
  if (-not $PathText) { return "" }
  return $PathText.ToLower().Replace('\', '/').TrimEnd('/')
}

function Get-WorkspaceStorageRoot {
  if ($env:APPDATA) {
    $candidate = Join-Path $env:APPDATA "Code/User/workspaceStorage"
    if (Test-Path $candidate) { return $candidate }
  }

  throw "Unable to locate VS Code workspaceStorage folder under %APPDATA%."
}

function Find-WorkspaceStorageFolders {
  param(
    [string]$StorageRoot,
    [string]$WorkspacePathValue
  )

  $targetPath = Normalize-PathString -PathText $WorkspacePathValue

  $workspaceMatches = @()
  $storageDirs = Get-ChildItem -Path $StorageRoot -Directory -ErrorAction SilentlyContinue

  foreach ($dir in $storageDirs) {
    $workspaceJson = Join-Path $dir.FullName "workspace.json"
    if (-not (Test-Path $workspaceJson)) { continue }

    try {
      $data = Get-Content -Path $workspaceJson -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
    }
    catch {
      continue
    }

    $folderUri = ""
    if ($data.PSObject.Properties.Name -contains "folder") { $folderUri = [string]$data.folder }
    elseif ($data.PSObject.Properties.Name -contains "workspace") { $folderUri = [string]$data.workspace }
    if ([string]::IsNullOrWhiteSpace($folderUri)) { continue }

    # Decode URI escaping (e.g. %20, %3A) then normalize for an exact path comparison.
    $decoded = [Uri]::UnescapeDataString($folderUri) -replace '^file:/+', ''
    $decoded = Normalize-PathString -PathText $decoded

    if ($decoded -eq $targetPath) {
      $workspaceMatches += $dir
    }
  }

  # Only ever read storage that matches the current project. If the workspace hash
  # cannot be matched with confidence, return nothing rather than inspecting other projects.
  return $workspaceMatches
}

function Infer-ActivityCategory {
  param(
    [string[]]$ToolIds = @(),
    [string]$ModeName = ""
  )

  # Classification uses only structured signals (tools invoked and mode).
  # Prompt and answer text are never read.
  $tools = ($ToolIds -join ",").ToLower()
  if ($tools -match "createfile") { return "code_generation" }
  if ($tools -match "applypatch|replacestring|insertedit") { return "refactor_editing" }
  if ($tools -match "run_in_terminal|geterrors|testfailure") { return "debugging_testing" }
  if ($tools -match "findtextinfiles|findfiles|listdirectory|readfile") { return "code_structure_reading" }
  if ($ModeName.ToLower() -eq "plan") { return "planning_docs" }

  return "unknown"
}

function Add-AttributionTokens {
  param(
    [hashtable]$Bucket,
    [string]$Key,
    [double]$Value
  )

  if (-not $Bucket.ContainsKey($Key)) {
    $Bucket[$Key] = 0.0
  }
  $Bucket[$Key] += $Value
}

function Get-RequestModeName {
  param([object]$Req)

  if ($null -eq $Req -or -not $Req.PSObject) { return "unknown" }
  if ($Req.PSObject.Properties.Name -contains "modeInfo" -and $Req.modeInfo) {
    if ($Req.modeInfo.PSObject -and $Req.modeInfo.PSObject.Properties.Name -contains "telemetryModeName") {
      $name = [string]$Req.modeInfo.telemetryModeName
      if (-not [string]::IsNullOrWhiteSpace($name)) { return $name }
    }

    if ($Req.modeInfo.PSObject -and $Req.modeInfo.PSObject.Properties.Name -contains "kind") {
      $kind = [string]$Req.modeInfo.kind
      if (-not [string]::IsNullOrWhiteSpace($kind)) { return $kind }
    }
  }

  return "unknown"
}

function Get-ToolIds {
  param([object]$Req)

  $toolIds = New-Object 'System.Collections.Generic.HashSet[string]'
  if ($null -eq $Req -or -not $Req.PSObject) { return @() }
  if (-not ($Req.PSObject.Properties.Name -contains "response")) { return @() }
  if (-not ($Req.response -is [System.Array])) { return @() }

  foreach ($item in $Req.response) {
    if ($null -eq $item -or -not $item.PSObject) { continue }
    if (-not ($item.PSObject.Properties.Name -contains "kind")) { continue }
    if ([string]$item.kind -ne "toolInvocationSerialized") { continue }

    if ($item.PSObject.Properties.Name -contains "toolId") {
      $toolId = [string]$item.toolId
      if (-not [string]::IsNullOrWhiteSpace($toolId)) {
        $null = $toolIds.Add($toolId)
      }
    }
  }

  return @($toolIds)
}

function Get-StrategyLabel {
  param(
    [string]$ModeName,
    [string[]]$ToolIds
  )

  # Strategy is inferred from structured signals only; text is never read.
  $toolText = ($ToolIds -join ",").ToLower()

  if ($toolText -match "runsubagent") { return "agent_subagent" }
  if ($toolText -match "askquestions|vscode_askquestions") { return "ask_clarification" }
  if ($ModeName.ToLower() -eq "plan") { return "plan_mode" }

  if ($toolText -match "createfile|applypatch|replacestring|insertedit|run_in_terminal") {
    return "implementation_prompt"
  }

  return "general_prompt"
}

$storageRoot = Get-WorkspaceStorageRoot
$workspaceFolders = Find-WorkspaceStorageFolders -StorageRoot $storageRoot -WorkspacePathValue $WorkspacePath

if (-not $workspaceFolders -or $workspaceFolders.Count -eq 0) {
  throw "No matching VS Code workspaceStorage folder with chat session data was found."
}

$totalPromptTokens = 0
$totalCompletionTokens = 0
$totalRequests = 0
$activityTotals = @{}
$sourceTotals = @{
  reading_data_tokens = 0.0
  reading_code_structure_tokens = 0.0
  user_prompt_tokens = 0.0
  system_overhead_tokens = 0.0
  answer_generation_tokens = 0.0
}
$actions = New-Object System.Collections.Generic.List[Object]
$sessionFiles = New-Object System.Collections.Generic.List[String]
$seenRequestIds = New-Object 'System.Collections.Generic.HashSet[string]'
$requestRecords = New-Object System.Collections.Generic.List[Object]
$modelTotals = @{}
$modeTotals = @{}

if ([string]::IsNullOrWhiteSpace($OutTranscript)) {
  $outDir = Split-Path -Parent $OutJson
  $OutTranscript = Join-Path $outDir "prompt-answer-log.jsonl"
}

foreach ($ws in $workspaceFolders) {
  $chatDir = Join-Path $ws.FullName "chatSessions"
  if (-not (Test-Path $chatDir)) { continue }

  $jsonlFiles = Get-ChildItem -Path $chatDir -Filter "*.jsonl" -File -ErrorAction SilentlyContinue
  foreach ($file in $jsonlFiles) {
    $sessionFiles.Add("session-" + (Get-AnonymousId -Text $file.Name).Substring(5, 8))

    $lines = Get-Content -Path $file.FullName -ErrorAction SilentlyContinue
    foreach ($line in $lines) {
      if ([string]::IsNullOrWhiteSpace($line)) { continue }

      try {
        $obj = $line | ConvertFrom-Json -ErrorAction Stop
      }
      catch {
        continue
      }

      # Copilot chatSessions store request snapshots in kind=2 records with k=requests.
        if ($obj.PSObject.Properties.Name -contains "kind" -and $obj.kind -eq 2 -and
          $obj.PSObject.Properties.Name -contains "k" -and
          ((($obj.k | ForEach-Object { $_.ToString() }) -join '/')) -eq "requests" -and
          $obj.PSObject.Properties.Name -contains "v") {

        $requestArray = $obj.v
        if (-not ($requestArray -is [System.Array])) {
          $requestArray = @($requestArray)
        }

        foreach ($req in $requestArray) {
          if ($null -eq $req -or -not $req.PSObject) { continue }
          if (-not ($req.PSObject.Properties.Name -contains "requestId")) { continue }

          $requestId = [string]$req.requestId
          if ([string]::IsNullOrWhiteSpace($requestId)) { continue }
          if ($seenRequestIds.Contains($requestId)) { continue }

          if (-not ($req.PSObject.Properties.Name -contains "promptTokens") -or
              -not ($req.PSObject.Properties.Name -contains "completionTokens")) {
            continue
          }

          $prompt = [int]$req.promptTokens
          $completion = [int]$req.completionTokens
          $total = $prompt + $completion
          $modelId = if ($req.PSObject.Properties.Name -contains "modelId") { [string]$req.modelId } else { "unknown" }
          if ([string]::IsNullOrWhiteSpace($modelId)) { $modelId = "unknown" }
          $modeName = Get-RequestModeName -Req $req
          $toolIds = Get-ToolIds -Req $req

          $null = $seenRequestIds.Add($requestId)
          $totalPromptTokens += $prompt
          $totalCompletionTokens += $completion
          $totalRequests += 1

          $strategy = Get-StrategyLabel -ModeName $modeName -ToolIds $toolIds

          $category = Infer-ActivityCategory -ToolIds $toolIds -ModeName $modeName

          # Exact prompt-side source attribution from Copilot prompt token details.
          $reqReadingDataTokens = 0.0
          $reqReadingCodeStructureTokens = 0.0
          $reqUserPromptTokens = 0.0
          $reqSystemOverheadTokens = 0.0

          if ($req.PSObject.Properties.Name -contains "promptTokenDetails" -and $req.promptTokenDetails) {
            foreach ($detail in $req.promptTokenDetails) {
              if ($null -eq $detail -or -not $detail.PSObject) { continue }
              if (-not ($detail.PSObject.Properties.Name -contains "percentageOfPrompt")) { continue }

              $pct = [double]$detail.percentageOfPrompt
              $detailTokens = ($prompt * $pct) / 100.0

              $detailCategory = ""
              $detailLabel = ""
              if ($detail.PSObject.Properties.Name -contains "category") { $detailCategory = [string]$detail.category }
              if ($detail.PSObject.Properties.Name -contains "label") { $detailLabel = [string]$detail.label }

              if ($detailCategory -eq "User Context" -and $detailLabel -eq "Files") {
                Add-AttributionTokens -Bucket $sourceTotals -Key "reading_code_structure_tokens" -Value $detailTokens
                $reqReadingCodeStructureTokens += $detailTokens
              }
              elseif ($detailCategory -eq "User Context" -and $detailLabel -eq "Tool Results") {
                Add-AttributionTokens -Bucket $sourceTotals -Key "reading_data_tokens" -Value $detailTokens
                $reqReadingDataTokens += $detailTokens
              }
              elseif ($detailCategory -eq "User Context" -and $detailLabel -eq "Messages") {
                Add-AttributionTokens -Bucket $sourceTotals -Key "user_prompt_tokens" -Value $detailTokens
                $reqUserPromptTokens += $detailTokens
              }
              elseif ($detailCategory -eq "System") {
                Add-AttributionTokens -Bucket $sourceTotals -Key "system_overhead_tokens" -Value $detailTokens
                $reqSystemOverheadTokens += $detailTokens
              }
            }
          }

          # Completion-side attribution: total answer generation only. Answer text is never read.
          Add-AttributionTokens -Bucket $sourceTotals -Key "answer_generation_tokens" -Value $completion

          $reqRecord = [pscustomobject]@{
            request_id = $requestId
            timestamp = if ($req.PSObject.Properties.Name -contains "timestamp") { $req.timestamp } else { "" }
            model_id = $modelId
            mode_name = $modeName
            strategy = $strategy
            tool_ids = @($toolIds)
            token_split = [pscustomobject]@{
              prompt_tokens = $prompt
              completion_tokens = $completion
              total_tokens = $total
            }
            prompt_source_split = [pscustomobject]@{
              reading_data_tokens = [math]::Round($reqReadingDataTokens)
              reading_code_structure_tokens = [math]::Round($reqReadingCodeStructureTokens)
              user_prompt_tokens = [math]::Round($reqUserPromptTokens)
              system_overhead_tokens = [math]::Round($reqSystemOverheadTokens)
            }
            answer_split = [pscustomobject]@{
              answer_generation_tokens = $completion
            }
            confidence = [pscustomobject]@{
              prompt_completion_tokens = "exact"
              prompt_source_split = "mapped_from_promptTokenDetails"
              answer_generation_tokens = "exact"
            }
          }
          $requestRecords.Add($reqRecord)

          if (-not $modelTotals.ContainsKey($modelId)) {
            $modelTotals[$modelId] = @{ requests = 0; total_tokens = 0 }
          }
          $modelTotals[$modelId].requests += 1
          $modelTotals[$modelId].total_tokens += $total

          if (-not $modeTotals.ContainsKey($modeName)) {
            $modeTotals[$modeName] = @{ requests = 0; total_tokens = 0 }
          }
          $modeTotals[$modeName].requests += 1
          $modeTotals[$modeName].total_tokens += $total

          if (-not $activityTotals.ContainsKey($category)) {
            $activityTotals[$category] = 0
          }
          $activityTotals[$category] += $total

          $actions.Add([pscustomobject]@{
            request_id = $requestId
            timestamp = if ($req.PSObject.Properties.Name -contains "timestamp") { $req.timestamp } else { "" }
            model_id = $modelId
            mode_name = $modeName
            strategy = $strategy
            category = $category
            prompt_tokens = $prompt
            completion_tokens = $completion
            total_tokens = $total
            confidence = if ($category -eq "unknown") { "low" } else { "medium" }
          })
        }
      }
    }
  }
}

$totalTokens = $totalPromptTokens + $totalCompletionTokens

$activityRows = @()
foreach ($key in $activityTotals.Keys) {
  $tokens = [int]$activityTotals[$key]
  $share = if ($totalTokens -gt 0) { [math]::Round(($tokens * 100.0) / $totalTokens, 2) } else { 0 }
  $activityRows += [pscustomobject]@{
    category = $key
    estimated_tokens = $tokens
    share_percent = $share
    confidence = if ($key -eq "unknown") { "low" } else { "medium" }
  }
}

$sourceRows = @()
foreach ($key in $sourceTotals.Keys) {
  $tokens = [math]::Round([double]$sourceTotals[$key])
  $share = if ($totalTokens -gt 0) { [math]::Round(($tokens * 100.0) / $totalTokens, 2) } else { 0 }
  $sourceRows += [pscustomobject]@{
    source = $key
    estimated_tokens = $tokens
    share_percent = $share
    confidence = "exact_or_mapped"
  }
}

$modelRows = @()
foreach ($modelKey in $modelTotals.Keys) {
  $reqCount = [int]$modelTotals[$modelKey].requests
  $tok = [int]$modelTotals[$modelKey].total_tokens
  $share = if ($totalTokens -gt 0) { [math]::Round(($tok * 100.0) / $totalTokens, 2) } else { 0 }
  $modelRows += [pscustomobject]@{
    model_id = $modelKey
    request_count = $reqCount
    total_tokens = $tok
    share_percent = $share
  }
}

$modeRows = @()
foreach ($modeKey in $modeTotals.Keys) {
  $reqCount = [int]$modeTotals[$modeKey].requests
  $tok = [int]$modeTotals[$modeKey].total_tokens
  $share = if ($totalTokens -gt 0) { [math]::Round(($tok * 100.0) / $totalTokens, 2) } else { 0 }
  $modeRows += [pscustomobject]@{
    mode_name = $modeKey
    request_count = $reqCount
    total_tokens = $tok
    share_percent = $share
  }
}


# Customization maturity: authored reusable customizations plus actual use of custom agents/modes.
$builtInModes = @('agent', 'ask', 'edit', 'plan')
$customModeRequests = 0
$customModeTokens = 0
foreach ($modeKey in $modeTotals.Keys) {
  if ($builtInModes -notcontains ([string]$modeKey).ToLower()) {
    $customModeRequests += [int]$modeTotals[$modeKey].requests
    $customModeTokens += [int]$modeTotals[$modeKey].total_tokens
  }
}

$subagentInvocations = 0
foreach ($rec in $requestRecords) {
  if ((@($rec.tool_ids) -join ",") -match "runSubagent") { $subagentInvocations += 1 }
}

$authoredAgents = 0
$authoredModes = 0
$authoredPrompts = 0
$authoredInstructions = 0
try {
  $custFiles = Get-ChildItem -Path $WorkspacePath -Recurse -File -ErrorAction SilentlyContinue -Include *.agent.md, *.chatmode.md, *.prompt.md, *.instructions.md, copilot-instructions.md, AGENTS.md
  foreach ($cf in $custFiles) {
    $n = $cf.Name.ToLower()
    if ($n -like "*.agent.md") { $authoredAgents += 1 }
    elseif ($n -like "*.chatmode.md") { $authoredModes += 1 }
    elseif ($n -like "*.prompt.md") { $authoredPrompts += 1 }
    else { $authoredInstructions += 1 }
  }
}
catch { }
$authoredTotal = $authoredAgents + $authoredModes + $authoredPrompts + $authoredInstructions

# Derived 0-100 score: authoring (<=50) + custom-mode use (<=25) + subagent delegation (<=25).
$authorScore = [math]::Min(50, $authoredTotal * 10)
$customUseScore = if ($totalRequests -gt 0) { [math]::Min(25, [math]::Round($customModeRequests * 100.0 / $totalRequests)) } else { 0 }
$delegationScore = if ($totalRequests -gt 0) { [math]::Min(25, [math]::Round(($subagentInvocations * 100.0 / $totalRequests) * 5)) } else { 0 }
$maturityScore = [int]($authorScore + $customUseScore + $delegationScore)

$customizationMaturity = [pscustomobject]@{
  maturity_score = $maturityScore
  authored = [pscustomobject]@{
    custom_agents = $authoredAgents
    custom_modes = $authoredModes
    prompt_files = $authoredPrompts
    instruction_files = $authoredInstructions
    total = $authoredTotal
  }
  custom_mode_usage = [pscustomobject]@{
    request_count = $customModeRequests
    total_tokens = $customModeTokens
    share_percent = if ($totalTokens -gt 0) { [math]::Round(($customModeTokens * 100.0) / $totalTokens, 2) } else { 0 }
  }
  delegation = [pscustomobject]@{
    subagent_invocations = $subagentInvocations
    share_percent = if ($totalRequests -gt 0) { [math]::Round(($subagentInvocations * 100.0) / $totalRequests, 2) } else { 0 }
  }
}

$summary = [pscustomobject]@{
  generated_at_utc = [DateTime]::UtcNow.ToString("o")
  submission_id = $anonymousId
  workspace_path = "<WORKSPACE>"
  source = [pscustomobject]@{
    provider = "github_copilot_chat"
    extraction_method = "vscode_workspace_chatSessions_jsonl"
    token_confidence = "exact"
    attribution_confidence = "inferred"
    session_files = $sessionFiles
  }
  totals = [pscustomobject]@{
    request_count = $totalRequests
    prompt_tokens = $totalPromptTokens
    completion_tokens = $totalCompletionTokens
    total_tokens = $totalTokens
  }
  attribution = @($activityRows | Sort-Object estimated_tokens -Descending)
  source_attribution = @($sourceRows | Sort-Object estimated_tokens -Descending)
  model_usage = @($modelRows | Sort-Object total_tokens -Descending)
  mode_usage = @($modeRows | Sort-Object total_tokens -Descending)
  customization_maturity = $customizationMaturity
  actions = $actions
  request_records = $requestRecords
}

$null = New-Item -ItemType Directory -Path (Split-Path -Parent $OutJson) -Force
$summary | ConvertTo-Json -Depth 8 | Set-Content -Path $OutJson -Encoding UTF8

$attribTableLines = @()
$attribTableLines += "| Category | Estimated Tokens | Share % | Confidence |"
$attribTableLines += "|---|---:|---:|---|"

foreach ($row in ($summary.attribution | Sort-Object estimated_tokens -Descending)) {
  $attribTableLines += "| $($row.category) | $($row.estimated_tokens) | $($row.share_percent) | $($row.confidence) |"
}

$topActions = $summary.actions | Sort-Object total_tokens -Descending | Select-Object -First 15
$actionTableLines = @()
$actionTableLines += "| # | Category | Prompt Tokens | Completion Tokens | Total |"
$actionTableLines += "|---:|---|---:|---:|---:|"

$index = 1
foreach ($a in $topActions) {
  $actionTableLines += "| $index | $($a.category) | $($a.prompt_tokens) | $($a.completion_tokens) | $($a.total_tokens) |"
  $index += 1
}

$sourceTableLines = @()
$sourceTableLines += "| Token Source | Estimated Tokens | Share % of Total | Confidence |"
$sourceTableLines += "|---|---:|---:|---|"

foreach ($row in ($summary.source_attribution | Sort-Object estimated_tokens -Descending)) {
  $sourceTableLines += "| $($row.source) | $($row.estimated_tokens) | $($row.share_percent) | $($row.confidence) |"
}

$modelTableLines = @()
$modelTableLines += "| Model | Requests | Total Tokens | Share % of Total |"
$modelTableLines += "|---|---:|---:|---:|"
foreach ($row in ($summary.model_usage | Sort-Object total_tokens -Descending)) {
  $modelTableLines += "| $($row.model_id) | $($row.request_count) | $($row.total_tokens) | $($row.share_percent) |"
}

$modeTableLines = @()
$modeTableLines += "| Mode | Requests | Total Tokens | Share % of Total |"
$modeTableLines += "|---|---:|---:|---:|"
foreach ($row in ($summary.mode_usage | Sort-Object total_tokens -Descending)) {
  $modeTableLines += "| $($row.mode_name) | $($row.request_count) | $($row.total_tokens) | $($row.share_percent) |"
}


$md = @"
# Copilot Usage Report

This file is auto-generated. Do not edit manually.

## Integrity Notice

- Contestants must not modify telemetry artifacts manually.
- Contestants must not ask any AI tool to modify telemetry artifacts.
- Any mismatch between raw logs and generated telemetry may lead to disqualification.

## Collection Metadata

- Generated at (UTC): $($summary.generated_at_utc)
- Submission ID: $($summary.submission_id)
- Workspace: <WORKSPACE> (anonymized)
- Source: VS Code Copilot chat session logs
- Token confidence: exact
- Activity attribution confidence: inferred

## Token Totals

- Requests counted: $($summary.totals.request_count)
- Prompt tokens: $($summary.totals.prompt_tokens)
- Completion tokens: $($summary.totals.completion_tokens)
- Total tokens: $($summary.totals.total_tokens)

## Activity Attribution (Inferred)

$($attribTableLines -join "`n")

## Token Source Attribution (Where Usage Comes From)

$($sourceTableLines -join "`n")

Interpretation:
- reading_data_tokens: prompt tokens attributed to tool results (terminal/search outputs brought into context)
- reading_code_structure_tokens: prompt tokens attributed to files added to context
- answer_generation_tokens: completion tokens Copilot generated in reply (exact count; answer text is never read)
- user_prompt_tokens and system_overhead_tokens are included for transparency

## Top Token-Heavy Actions

$($actionTableLines -join "`n")

## Model Usage by Prompt

$($modelTableLines -join "`n")

## Mode Usage (Agent, Plan, Ask Workflow)

$($modeTableLines -join "`n")

## Custom Agent and Prompting Maturity

- Maturity score (0-100): $($summary.customization_maturity.maturity_score)
- Authored customizations: $($summary.customization_maturity.authored.total) (custom agents: $($summary.customization_maturity.authored.custom_agents), custom modes: $($summary.customization_maturity.authored.custom_modes), prompt files: $($summary.customization_maturity.authored.prompt_files), instruction files: $($summary.customization_maturity.authored.instruction_files))
- Custom mode usage: $($summary.customization_maturity.custom_mode_usage.request_count) requests ($($summary.customization_maturity.custom_mode_usage.share_percent)% of tokens)
- Subagent delegation: $($summary.customization_maturity.delegation.subagent_invocations) invocations ($($summary.customization_maturity.delegation.share_percent)% of requests)

Interpretation: higher scores reflect building and using reusable customizations (custom agents/modes, prompt files, instructions) and delegating scoped work to subagents. Only counts are recorded; no file names or content are collected.

## Prompt and Answer Allocation

- The collector never reads the text of prompts or answers. Only token counts and structured metadata (model, mode, tools) are processed.
- Per-request token allocation (no content) is in: .github/copilot-usage/prompt-answer-log.jsonl
- Structured per-request records (no content) are also embedded in: .github/copilot-usage/usage-summary.json under request_records

## Submission Guidance

Submit this file, .github/copilot-usage/usage-summary.json, and .github/copilot-usage/prompt-answer-log.jsonl with the project.

Do not edit these telemetry files manually or through AI-assisted edits.
"@

$null = New-Item -ItemType Directory -Path (Split-Path -Parent $OutMarkdown) -Force
$md | Set-Content -Path $OutMarkdown -Encoding UTF8

$null = New-Item -ItemType Directory -Path (Split-Path -Parent $OutTranscript) -Force
if (Test-Path $OutTranscript) {
  Remove-Item -Path $OutTranscript -Force
}
foreach ($record in $requestRecords) {
  ($record | ConvertTo-Json -Depth 8 -Compress) | Add-Content -Path $OutTranscript -Encoding UTF8
}

Write-Output "Generated usage summary at: $OutJson"
Write-Output "Generated markdown report at: $OutMarkdown"
Write-Output "Generated prompt/answer transcript at: $OutTranscript"
