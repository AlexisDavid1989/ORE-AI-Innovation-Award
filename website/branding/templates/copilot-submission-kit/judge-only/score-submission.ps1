param(
  [Parameter(Mandatory = $true)]
  [string]$UsageSummaryJson,

  [Parameter(Mandatory = $false)]
  [string]$OutJson = "judge-score.json",

  [Parameter(Mandatory = $false)]
  [string]$OutMarkdown = "JUDGE_SCORE_REPORT.md"
)

$ErrorActionPreference = "Stop"

function Clamp-Score {
  param([double]$Value)
  if ($Value -lt 0) { return 0 }
  if ($Value -gt 100) { return 100 }
  return [math]::Round($Value, 2)
}

function Evaluate-DecisionQuality {
  param(
    [string]$PromptText,
    [int]$TotalTokens,
    [string]$ModelId,
    [string]$ModeName,
    [string[]]$ToolIds
  )

  $score = 50
  $notes = New-Object System.Collections.Generic.List[string]

  $lowerPrompt = if ($PromptText) { $PromptText.ToLower() } else { "" }
  $toolText = ($ToolIds -join ",").ToLower()
  $isMicro = $lowerPrompt -match "^(a bit more|a bit less|still not|nope|thinner|more elements|even thinner)$"
  $needsClarification = $lowerPrompt -match "\?|\b(not sure|how|what|which|could we|is there a way)\b"
  $isClearImplementation = $lowerPrompt -match "\b(start implementation|implement|apply to current project|generate report|capture exact prompt|build collector)\b"
  $hasSubagent = $toolText -match "runsubagent"
  $hasAskTool = $toolText -match "askquestions|vscode_askquestions"
  $isPlanMode = $ModeName.ToLower() -eq "plan"

  if ($needsClarification -and ($hasAskTool -or $hasSubagent -or $isPlanMode)) {
    $score += 15
    $notes.Add("Used planning or clarification workflow for an ambiguous request.")
  }

  if ($isMicro -and ($hasSubagent -or $hasAskTool)) {
    $score -= 15
    $notes.Add("High-overhead workflow used for a micro-iteration prompt.")
  }

  if ($isMicro -and $TotalTokens -gt 60000) {
    $score -= 10
    $notes.Add("Micro-iteration consumed very high context tokens; batching changes would be cheaper.")
  }

  if ($isPlanMode -and $lowerPrompt -match "\b(start implementation|implement|create files|build now)\b") {
    $score -= 8
    $notes.Add("Implementation request in plan mode can create unnecessary handoff overhead.")
  }

  if ($isClearImplementation -and -not $hasAskTool -and -not $hasSubagent) {
    $score += 12
    $notes.Add("Direct implementation prompt matched with low-overhead execution path.")
  }

  if ($isMicro -and $TotalTokens -gt 120000) {
    $score -= 10
    $notes.Add("Very high token cost on micro prompt suggests context reset would help.")
  }

  if ($ModelId -match "copilot/auto") {
    $score += 5
    $notes.Add("Auto model routing is generally a safe default.")
  }

  if ($score -gt 100) { $score = 100 }
  if ($score -lt 0) { $score = 0 }

  $rating = "ok"
  if ($score -ge 65) { $rating = "good" }
  elseif ($score -le 45) { $rating = "poor" }

  if ($notes.Count -eq 0) {
    $notes.Add("No strong signal for misuse or standout optimization in this request.")
  }

  return [pscustomobject]@{
    score = $score
    rating = $rating
    notes = @($notes)
  }
}

function Compute-TokenEfficiencyScore {
  param(
    [double]$AvgTokensPerRequest,
    [double]$CompletionSharePercent
  )

  $target = 30000.0
  $warning = 80000.0
  $poor = 140000.0

  if ($AvgTokensPerRequest -le $target) {
    $score = 95
  }
  elseif ($AvgTokensPerRequest -le $warning) {
    $score = 95 - ((($AvgTokensPerRequest - $target) / ($warning - $target)) * 30)
  }
  elseif ($AvgTokensPerRequest -le $poor) {
    $score = 65 - ((($AvgTokensPerRequest - $warning) / ($poor - $warning)) * 35)
  }
  else {
    $score = 30
  }

  if ($CompletionSharePercent -lt 2) {
    $score -= 8
  }

  return Clamp-Score -Value $score
}

function Compute-SolutionQualityScore {
  param(
    [int]$PositiveAckCount,
    [int]$ReworkSignalCount,
    [int]$ImplementationPromptCount
  )

  $base = 60.0
  $qualityLift = (20.0 * ($PositiveAckCount / [double]([math]::Max(1, $PositiveAckCount + $ReworkSignalCount))))
  $executionLift = if ($ImplementationPromptCount -gt 0) { 12.0 } else { 0.0 }
  $reworkPenalty = [math]::Min(20.0, $ReworkSignalCount * 1.5)

  return Clamp-Score -Value ($base + $qualityLift + $executionLift - $reworkPenalty)
}

function Compute-PromptingQualityScore {
  param(
    [double]$AverageDecisionScore,
    [double]$MicroPromptRatio,
    [int]$PoorDecisionCount
  )

  $score = $AverageDecisionScore
  if ($MicroPromptRatio -gt 0.18) { $score -= 10 }
  if ($PoorDecisionCount -gt 0) { $score -= [math]::Min(15, ($PoorDecisionCount * 2)) }

  return Clamp-Score -Value $score
}

function Compute-ProcessTransparencyScore {
  param(
    [int]$RequestCount,
    [int]$PromptAnswerCoverageCount,
    [int]$ModelCoverageCount,
    [int]$DecisionCoverageCount
  )

  if ($RequestCount -le 0) { return 0 }

  $promptAnswerRatio = $PromptAnswerCoverageCount / [double]$RequestCount
  $modelRatio = $ModelCoverageCount / [double]$RequestCount
  $decisionRatio = $DecisionCoverageCount / [double]$RequestCount

  return Clamp-Score -Value ((0.5 * $promptAnswerRatio + 0.25 * $modelRatio + 0.25 * $decisionRatio) * 100)
}

$summary = Get-Content -Path $UsageSummaryJson -Raw | ConvertFrom-Json
if (-not $summary.request_records) {
  throw "usage-summary.json does not contain request_records."
}

$weights = [pscustomobject]@{
  solution_quality = 50
  prompting_quality = 20
  token_efficiency = 20
  process_transparency = 10
}

$requestRecords = @($summary.request_records)
$requestCount = [int]$summary.totals.request_count
$totalTokens = [int]$summary.totals.total_tokens
$completionTokens = [int]$summary.totals.completion_tokens
$avgTokensPerRequest = if ($requestCount -gt 0) { [math]::Round($totalTokens / $requestCount, 2) } else { 0 }
$completionSharePercent = if ($totalTokens -gt 0) { [math]::Round(($completionTokens * 100.0) / $totalTokens, 2) } else { 0 }

$decisionScores = New-Object System.Collections.Generic.List[int]
$goodCount = 0
$okCount = 0
$poorCount = 0
$microPromptCount = 0
$reworkSignalCount = 0
$positiveAckCount = 0
$implementationPromptCount = 0
$promptAnswerCoverageCount = 0
$modelCoverageCount = 0

foreach ($r in $requestRecords) {
  $promptText = [string]$r.prompt_text
  $answerText = [string]$r.answer_text
  $modelId = [string]$r.model_id
  $modeName = [string]$r.mode_name
  $toolIds = @()
  if ($r.PSObject.Properties.Name -contains "tool_ids") {
    $toolIds = @($r.tool_ids)
  }

  $total = 0
  if ($r.token_split -and $r.token_split.total_tokens) {
    $total = [int]$r.token_split.total_tokens
  }

  $d = Evaluate-DecisionQuality -PromptText $promptText -TotalTokens $total -ModelId $modelId -ModeName $modeName -ToolIds $toolIds
  $decisionScores.Add([int]$d.score)
  if ($d.rating -eq "good") { $goodCount += 1 }
  elseif ($d.rating -eq "poor") { $poorCount += 1 }
  else { $okCount += 1 }

  $promptLower = if ($promptText) { $promptText.ToLower() } else { "" }
  if ($promptLower -match "^(a bit more|a bit less|still not|nope|thinner|more elements|even thinner)$") { $microPromptCount += 1 }
  if ($promptLower -match "\b(still not|nope|not exactly|i dont see|i don't see|a bit more|a bit less)\b") { $reworkSignalCount += 1 }
  if ($promptLower -match "\b(good|great|perfect|that's the one|thats the one|done|looks good)\b") { $positiveAckCount += 1 }
  if ($promptLower -match "\b(start implementation|implement|apply to current project|build)\b") { $implementationPromptCount += 1 }

  if (-not [string]::IsNullOrWhiteSpace($promptText) -and -not [string]::IsNullOrWhiteSpace($answerText)) { $promptAnswerCoverageCount += 1 }
  if (-not [string]::IsNullOrWhiteSpace($modelId) -and $modelId -ne "unknown") { $modelCoverageCount += 1 }
}

$avgDecisionScore = if ($decisionScores.Count -gt 0) { [math]::Round((($decisionScores | Measure-Object -Average).Average), 2) } else { 0 }
$microPromptRatio = if ($requestCount -gt 0) { [math]::Round($microPromptCount / $requestCount, 4) } else { 0 }

$solutionQualityScore = Compute-SolutionQualityScore -PositiveAckCount $positiveAckCount -ReworkSignalCount $reworkSignalCount -ImplementationPromptCount $implementationPromptCount
$promptingQualityScore = Compute-PromptingQualityScore -AverageDecisionScore $avgDecisionScore -MicroPromptRatio $microPromptRatio -PoorDecisionCount $poorCount
$tokenEfficiencyScore = Compute-TokenEfficiencyScore -AvgTokensPerRequest $avgTokensPerRequest -CompletionSharePercent $completionSharePercent
$processTransparencyScore = Compute-ProcessTransparencyScore -RequestCount $requestCount -PromptAnswerCoverageCount $promptAnswerCoverageCount -ModelCoverageCount $modelCoverageCount -DecisionCoverageCount $decisionScores.Count

$finalScore = [math]::Round((
  $solutionQualityScore * ($weights.solution_quality / 100.0) +
  $promptingQualityScore * ($weights.prompting_quality / 100.0) +
  $tokenEfficiencyScore * ($weights.token_efficiency / 100.0) +
  $processTransparencyScore * ($weights.process_transparency / 100.0)
), 2)

$result = [pscustomobject]@{
  generated_at_utc = [DateTime]::UtcNow.ToString("o")
  rubric_name = "ORE_Awards_Strict_v1"
  weights = $weights
  final_score_100 = $finalScore
  components = [pscustomobject]@{
    solution_quality = $solutionQualityScore
    prompting_quality = $promptingQualityScore
    token_efficiency = $tokenEfficiencyScore
    process_transparency = $processTransparencyScore
  }
  diagnostics = [pscustomobject]@{
    request_count = $requestCount
    avg_tokens_per_request = $avgTokensPerRequest
    completion_share_percent = $completionSharePercent
    micro_prompt_ratio = $microPromptRatio
    rework_signal_count = $reworkSignalCount
    positive_ack_count = $positiveAckCount
    implementation_prompt_count = $implementationPromptCount
    average_decision_score = $avgDecisionScore
    decision_good = $goodCount
    decision_ok = $okCount
    decision_poor = $poorCount
  }
  confidence = "heuristic"
}

$result | ConvertTo-Json -Depth 8 | Set-Content -Path $OutJson -Encoding UTF8

$md = @"
# Judge Score Report

This report is for judges only.

- Generated at (UTC): $($result.generated_at_utc)
- Rubric profile: $($result.rubric_name)
- Final score (/100): $($result.final_score_100)

## Weighted Components

| Component | Raw Score | Weight % | Weighted |
|---|---:|---:|---:|
| Solution quality | $($result.components.solution_quality) | $($result.weights.solution_quality) | $([math]::Round($result.components.solution_quality * ($result.weights.solution_quality / 100.0),2)) |
| Prompting quality | $($result.components.prompting_quality) | $($result.weights.prompting_quality) | $([math]::Round($result.components.prompting_quality * ($result.weights.prompting_quality / 100.0),2)) |
| Token efficiency | $($result.components.token_efficiency) | $($result.weights.token_efficiency) | $([math]::Round($result.components.token_efficiency * ($result.weights.token_efficiency / 100.0),2)) |
| Process transparency | $($result.components.process_transparency) | $($result.weights.process_transparency) | $([math]::Round($result.components.process_transparency * ($result.weights.process_transparency / 100.0),2)) |

## Diagnostics

| Metric | Value |
|---|---:|
| Requests | $($result.diagnostics.request_count) |
| Avg tokens/request | $($result.diagnostics.avg_tokens_per_request) |
| Completion share % | $($result.diagnostics.completion_share_percent) |
| Micro prompt ratio | $($result.diagnostics.micro_prompt_ratio) |
| Rework signal count | $($result.diagnostics.rework_signal_count) |
| Positive ack count | $($result.diagnostics.positive_ack_count) |
| Implementation prompt count | $($result.diagnostics.implementation_prompt_count) |
| Average decision score | $($result.diagnostics.average_decision_score) |
| Decision good/ok/poor | $($result.diagnostics.decision_good) / $($result.diagnostics.decision_ok) / $($result.diagnostics.decision_poor) |
"@

$md | Set-Content -Path $OutMarkdown -Encoding UTF8

Write-Output "Generated judge score JSON: $OutJson"
Write-Output "Generated judge score markdown: $OutMarkdown"
