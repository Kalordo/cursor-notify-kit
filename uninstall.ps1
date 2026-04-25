param()

$ErrorActionPreference = "Stop"

$homeCursor = Join-Path $env:USERPROFILE ".cursor"
$hooksDir = Join-Path $homeCursor "hooks"
$hooksJsonPath = Join-Path $homeCursor "hooks.json"
$backupDir = Join-Path $homeCursor ("hooks-uninstall-backup-" + (Get-Date -Format "yyyyMMdd-HHmmss"))

New-Item -ItemType Directory -Force -Path $backupDir | Out-Null

$pathsToBackup = @(
    $hooksJsonPath,
    (Join-Path $hooksDir "cursor-sound.ps1"),
    (Join-Path $hooksDir "mobile-notify.json"),
    (Join-Path $hooksDir "cursor-sound.log"),
    (Join-Path $hooksDir "cursor-sound-state.txt")
)

foreach ($path in $pathsToBackup) {
    if (Test-Path $path) {
        Copy-Item $path -Destination $backupDir -Force
    }
}

if (Test-Path $hooksJsonPath) {
    $content = Get-Content $hooksJsonPath -Raw
    if ($content -match "cursor-sound\.ps1") {
        Remove-Item $hooksJsonPath -Force
    } else {
        Write-Host "hooks.json non supprime (il ne semble pas provenir de cursor-notify-kit)."
    }
}

$ownedFiles = @(
    (Join-Path $hooksDir "cursor-sound.ps1"),
    (Join-Path $hooksDir "mobile-notify.json"),
    (Join-Path $hooksDir "cursor-sound.log"),
    (Join-Path $hooksDir "cursor-sound-state.txt")
)

foreach ($path in $ownedFiles) {
    if (Test-Path $path) {
        Remove-Item $path -Force
    }
}

Write-Host ""
Write-Host "Desinstallation terminee."
Write-Host "Backup cree: $backupDir"
