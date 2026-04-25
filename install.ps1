param(
    [string]$Topic = "",
    [switch]$DisableMobile
)

$ErrorActionPreference = "Stop"

function New-RandomTopic {
    $chars = "abcdefghijklmnopqrstuvwxyz0123456789"
    $suffix = -join (1..10 | ForEach-Object { $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)] })
    return "cursor-notify-$suffix"
}

$homeCursor = Join-Path $env:USERPROFILE ".cursor"
$hooksDir = Join-Path $homeCursor "hooks"
$sourceDir = Join-Path $PSScriptRoot "templates"
$backupDir = Join-Path $homeCursor ("hooks-backup-" + (Get-Date -Format "yyyyMMdd-HHmmss"))

if (-not (Test-Path $homeCursor)) {
    throw "Le dossier $homeCursor est introuvable."
}
if (-not (Test-Path $sourceDir)) {
    throw "Le dossier templates est introuvable: $sourceDir"
}

New-Item -ItemType Directory -Force -Path $hooksDir | Out-Null
New-Item -ItemType Directory -Force -Path $backupDir | Out-Null

$filesToBackup = @(
    (Join-Path $homeCursor "hooks.json"),
    (Join-Path $hooksDir "cursor-sound.ps1"),
    (Join-Path $hooksDir "mobile-notify.json"),
    (Join-Path $hooksDir "cursor-sound.log"),
    (Join-Path $hooksDir "cursor-sound-state.txt")
)

foreach ($path in $filesToBackup) {
    if (Test-Path $path) {
        Copy-Item $path -Destination $backupDir -Force
    }
}

Copy-Item (Join-Path $sourceDir "cursor-sound.ps1") (Join-Path $hooksDir "cursor-sound.ps1") -Force
Copy-Item (Join-Path $sourceDir "hooks.json") (Join-Path $homeCursor "hooks.json") -Force

if (-not $DisableMobile) {
    if ([string]::IsNullOrWhiteSpace($Topic)) {
        $Topic = New-RandomTopic
    }
    $mobileTemplatePath = Join-Path $sourceDir "mobile-notify.json"
    $mobileContent = Get-Content $mobileTemplatePath -Raw
    $mobileContent = $mobileContent.Replace("__CHANGE_ME_TOPIC__", $Topic)
    Set-Content -Path (Join-Path $hooksDir "mobile-notify.json") -Value $mobileContent -Encoding UTF8
}

Write-Host ""
Write-Host "Installation terminee."
Write-Host "Backup cree: $backupDir"
Write-Host "Hooks installs: $homeCursor\hooks.json + $hooksDir\cursor-sound.ps1"
if (-not $DisableMobile) {
    Write-Host "Push mobile ntfy active. Topic: $Topic"
    Write-Host "Abonne ton telephone a ce topic dans l'app ntfy."
} else {
    Write-Host "Push mobile desactive (--DisableMobile)."
}
