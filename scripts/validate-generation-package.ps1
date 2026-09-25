param(
    [Parameter(Mandatory = $true)]
    [string]$Path
)

$ErrorActionPreference = "Stop"

$resolved = (Resolve-Path -LiteralPath $Path).Path
$tempDir = $null
$repoRoot = Split-Path -Parent $PSScriptRoot
$tempRoot = Join-Path $repoRoot "dist"

try {
    if (Test-Path -LiteralPath $resolved -PathType Leaf) {
        $sourceFile = Get-Item -LiteralPath $resolved
        if ($sourceFile.Extension -ne ".zip") {
            throw "Package path must be a directory or ZIP file."
        }

        New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null
        $tempDir = Join-Path $tempRoot (".tmp-generation-package-" + (Get-Random))
        New-Item -ItemType Directory -Path $tempDir | Out-Null
        Expand-Archive -LiteralPath $resolved -DestinationPath $tempDir
        $root = $tempDir
    } else {
        $root = $resolved
    }

    $files = @(Get-ChildItem -LiteralPath $root -Recurse -File)
    if ($files.Count -eq 0) {
        throw "Generation package is empty."
    }

    $allowed = @(".txt", ".png", ".jpg", ".jpeg", ".webp")
    $forbidden = @($files | Where-Object { $allowed -notcontains $_.Extension })
    if ($forbidden.Count -gt 0) {
        $names = ($forbidden | ForEach-Object { $_.Name }) -join ", "
        throw "Generation package contains forbidden file types: $names"
    }

    $prompts = @($files | Where-Object { $_.Extension -eq ".txt" })
    if ($prompts.Count -eq 0) {
        throw "Generation package contains no prompt TXT files."
    }

    $images = @($files | Where-Object { @(".png", ".jpg", ".jpeg", ".webp") -contains $_.Extension })
    $duplicates = @($images | Group-Object Name | Where-Object { $_.Count -gt 1 })
    if ($duplicates.Count -gt 0) {
        $names = ($duplicates | ForEach-Object { $_.Name }) -join ", "
        throw "Generation package contains duplicate image basenames: $names"
    }

    $imageNames = @($images | ForEach-Object { $_.Name })
    $missing = @()
    $pattern = '(?i)([^\s"''<>|]+?\.(?:png|jpe?g|webp))'

    foreach ($prompt in $prompts) {
        $text = Get-Content -LiteralPath $prompt.FullName -Raw -Encoding UTF8
        $scan = Select-String -InputObject $text -Pattern $pattern -AllMatches
        foreach ($match in $scan.Matches) {
            $token = $match.Groups[1].Value -replace '[,;\)\]\}]+$',''
            $leaf = Split-Path -Leaf $token
            if ($imageNames -notcontains $leaf) {
                $missing += "$($prompt.Name) -> $leaf"
            }
        }
    }

    if ($missing.Count -gt 0) {
        $uniqueMissing = @($missing | Sort-Object -Unique)
        throw ("Prompt references missing image files: " + ($uniqueMissing -join ", "))
    }

    Write-Output "Generation package validation passed."
    Write-Output ("Prompt TXT files: " + $prompts.Count)
    Write-Output ("Reference images: " + $images.Count)
    Write-Output "Allowed contents: TXT + PNG/JPG/JPEG/WebP only."
}
finally {
    if ($tempDir -and (Test-Path -LiteralPath $tempDir)) {
        Remove-Item -LiteralPath $tempDir -Recurse -Force
    }
}
