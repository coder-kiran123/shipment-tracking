# Shipment Tracking - setup for Windows.
# In PowerShell run:
#   irm https://raw.githubusercontent.com/coder-kiran123/shipment-tracking/main/install-windows.ps1 | iex
$ErrorActionPreference = "Stop"
$Repo = "coder-kiran123/shipment-tracking"
$Dir  = "$HOME\sirjan"

Write-Host "== 1/4 Checking Google Chrome =="
$chrome = @("$env:ProgramFiles\Google\Chrome\Application\chrome.exe","${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe","$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $chrome) { winget install -e --id Google.Chrome --accept-source-agreements --accept-package-agreements }

Write-Host "== 2/4 Installing Git and Claude =="
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { winget install -e --id Git.Git --accept-source-agreements --accept-package-agreements }
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) { irm https://claude.ai/install.ps1 | iex }
$userPath = [Environment]::GetEnvironmentVariable("Path","User")
if ($userPath -notlike "*\.local\bin*") { [Environment]::SetEnvironmentVariable("Path", "$userPath;$HOME\.local\bin", "User") }
$env:Path = [Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [Environment]::GetEnvironmentVariable("Path","User")

Write-Host "== 3/4 Downloading tracking system =="
if (Test-Path "$Dir\.git") { git -C $Dir pull -q } else { git clone -q "https://github.com/$Repo.git" $Dir }

Write-Host "== 4/4 Claude in Chrome extension =="
Start-Process "https://chromewebstore.google.com/search/Claude%20in%20Chrome"
Read-Host ">> In Chrome: Add 'Claude in Chrome' and sign in. Press Enter when done"

Write-Host "DONE! First time: Enter for theme, log in, Yes to trust folder. Then type: /track"
Set-Location $Dir
claude --chrome
