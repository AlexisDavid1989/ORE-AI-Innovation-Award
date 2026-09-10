param(
    [Parameter(Mandatory = $true)]
    [string]$InputSvgPath,

    [string]$OutFile,

    [switch]$AsImgTag
)

$resolvedInputPath = (Resolve-Path -Path $InputSvgPath).Path
$svg = Get-Content -Raw -Path $resolvedInputPath

$minifiedSvg = ($svg -replace '>\s+<', '><' -replace '\r?\n', '' -replace '\s{2,}', ' ').Trim()
$base64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($minifiedSvg))
$dataUri = "data:image/svg+xml;base64,$base64"

if ($AsImgTag) {
    $output = ('<img src="{0}" alt="Embedded SVG">' -f $dataUri)
}
else {
    $output = $dataUri
}

if ($OutFile) {
    Set-Content -Path $OutFile -Value $output -Encoding utf8
}
else {
    $output
}