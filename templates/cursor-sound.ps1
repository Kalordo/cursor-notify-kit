param()

try {
    $statePath = Join-Path $PSScriptRoot "cursor-sound-state.txt"
    $logPath = Join-Path $PSScriptRoot "cursor-sound.log"
    $mobileConfigPath = Join-Path $PSScriptRoot "mobile-notify.json"
    $now = Get-Date

    # Avoid repeated sound when hooks fire in quick succession.
    if (Test-Path $statePath) {
        $ageSeconds = ($now - (Get-Item $statePath).LastWriteTime).TotalSeconds
        if ($ageSeconds -lt 2.5) {
            Add-Content -Path $logPath -Value ("[{0}] Skipped duplicate trigger" -f ($now.ToString("yyyy-MM-dd HH:mm:ss")))
            return
        }
    }
    Set-Content -Path $statePath -Value "1"
    Add-Content -Path $logPath -Value ("[{0}] Sound hook triggered" -f ($now.ToString("yyyy-MM-dd HH:mm:ss")))

    $wavCandidates = @(
        (Join-Path $PSScriptRoot "cursor-notify.wav"),
        "C:\Windows\Media\chimes.wav",
        "C:\Windows\Media\notify.wav",
        "C:\Windows\Media\Windows Notify Messaging.wav",
        "C:\Windows\Media\Windows Notify System Generic.wav"
    )
    $wavPath = $wavCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1

    if ($wavPath) {
        $player = New-Object System.Media.SoundPlayer $wavPath
        $player.PlaySync()
        Add-Content -Path $logPath -Value ("[{0}] Played wav: {1}" -f ((Get-Date).ToString("yyyy-MM-dd HH:mm:ss")), $wavPath)
    } else {
        [System.Media.SystemSounds]::Asterisk.Play()
        Start-Sleep -Milliseconds 250
        Add-Content -Path $logPath -Value ("[{0}] Played fallback system sound" -f ((Get-Date).ToString("yyyy-MM-dd HH:mm:ss")))
    }

    if (Test-Path $mobileConfigPath) {
        try {
            $mobileConfig = Get-Content $mobileConfigPath -Raw | ConvertFrom-Json
            if ($mobileConfig.enabled -eq $true -and $mobileConfig.provider -eq "ntfy" -and $mobileConfig.topic) {
                $server = $mobileConfig.server
                if (-not $server) { $server = "https://ntfy.sh" }
                $message = "Cursor a termine une reponse."
                $headers = @{
                    "Title" = "Cursor"
                    "Priority" = "default"
                    "Tags" = "computer"
                }
                Invoke-RestMethod -Method Post -Uri "$server/$($mobileConfig.topic)" -Headers $headers -Body $message -TimeoutSec 6 | Out-Null
                Add-Content -Path $logPath -Value ("[{0}] Mobile push sent (ntfy topic={1})" -f ((Get-Date).ToString("yyyy-MM-dd HH:mm:ss")), $mobileConfig.topic)
            }
        } catch {
            Add-Content -Path $logPath -Value ("[{0}] Mobile push error: {1}" -f ((Get-Date).ToString("yyyy-MM-dd HH:mm:ss")), $_.Exception.Message)
        }
    }
} catch {
    try {
        Add-Content -Path $logPath -Value ("[{0}] Hook error: {1}" -f ((Get-Date).ToString("yyyy-MM-dd HH:mm:ss")), $_.Exception.Message)
    } catch {
        # Keep hook non-blocking and silent on errors.
    }
}
