param(
    [string]$OutputDir = "dist"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

$manifestPath = Join-Path $repoRoot "plugin.json"
$skillRoot = Join-Path $repoRoot "skills"

if (!(Test-Path -LiteralPath $manifestPath)) {
    throw "Missing plugin.json at repository root."
}

if (!(Test-Path -LiteralPath $skillRoot)) {
    throw "Missing skills/ directory."
}

$manifestPrefix = [System.IO.File]::ReadAllBytes($manifestPath)
if ($manifestPrefix.Count -ge 3 -and
    $manifestPrefix[0] -eq 239 -and
    $manifestPrefix[1] -eq 187 -and
    $manifestPrefix[2] -eq 191) {
    throw "plugin.json has a UTF-8 BOM. Save it as UTF-8 without BOM before packaging."
}

$manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
if (!$manifest.name) {
    throw "plugin.json is missing name."
}
if (!$manifest.version) {
    throw "plugin.json is missing version."
}

$skillFiles = @(Get-ChildItem -LiteralPath $skillRoot -Recurse -File -Filter "SKILL.md")
if ($skillFiles.Count -lt 1) {
    throw "No skills/*/SKILL.md found."
}

$resolvedOutputDir = Join-Path $repoRoot $OutputDir
New-Item -ItemType Directory -Force -Path $resolvedOutputDir | Out-Null

$zipName = "$($manifest.name)-chatgpt-upload-$($manifest.version).zip"
$zipPath = Join-Path $resolvedOutputDir $zipName
if (Test-Path -LiteralPath $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
}

$packagePaths = @(
    (Join-Path $repoRoot "plugin.json"),
    (Join-Path $repoRoot "skills")
)
Compress-Archive -Path $packagePaths -DestinationPath $zipPath -CompressionLevel Optimal

$entries = @(tar -tf $zipPath)
if ($LASTEXITCODE -ne 0) {
    throw "Failed to inspect generated ZIP."
}

if ($entries -notcontains "plugin.json") {
    throw "Generated ZIP does not contain plugin.json at ZIP root."
}

if (-not ($entries | Where-Object { $_ -match '^skills/[^/]+/SKILL\.md$' })) {
    throw "Generated ZIP does not contain skills/<name>/SKILL.md."
}

$forbidden = @(
    '^\.agents/',
    '^README\.md$',
    '^AGENTS\.md$',
    '^\.git/',
    '^dist/'
)

foreach ($pattern in $forbidden) {
    if ($entries | Where-Object { $_ -match $pattern }) {
        throw "Generated ZIP contains forbidden entry matching: $pattern"
    }
}

Write-Output "ChatGPT upload ZIP ready:"
Get-Item -LiteralPath $zipPath | Select-Object FullName, Length
Write-Output "Archive contents:"
$entries

