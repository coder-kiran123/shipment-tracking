# Shipment Tracking - setup for Windows.
# Right-click this file -> "Run with PowerShell"
$ErrorActionPreference = "Stop"
$Repo = "coder-kiran123/shipment-tracking"
$Dir  = "$HOME\sirjan"

Write-Host "== 1/5 Checking Google Chrome =="
$chrome = @("$env:ProgramFiles\Google\Chrome\Application\chrome.exe","${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe","$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $chrome) { winget install -e --id Google.Chrome --accept-source-agreements --accept-package-agreements }

Write-Host "== 2/5 Installing Git, GitHub tool and Claude =="
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { winget install -e --id Git.Git --accept-source-agreements --accept-package-agreements }
if (-not (Get-Command gh  -ErrorAction SilentlyContinue)) { winget install -e --id GitHub.cli --accept-source-agreements --accept-package-agreements }
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) { irm https://claude.ai/install.ps1 | iex }
$env:Path = [Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [Environment]::GetEnvironmentVariable("Path","User") + ";$HOME\.local\bin"

Write-Host "== 3/5 GitHub login (account coder-kiran123) =="
gh auth status 2>$null; if ($LASTEXITCODE -ne 0) { gh auth login --web -h github.com -p https --git-protocol https }

Write-Host "== 4/5 Downloading tracking system =="
if (Test-Path "$Dir\.git") { git -C $Dir pull -q } else { gh repo clone $Repo $Dir }

Write-Host "== 5/5 Claude in Chrome extension =="
Start-Process "https://chromewebstore.google.com/search/Claude%20in%20Chrome"
Read-Host ">> In Chrome: Add 'Claude in Chrome' and sign in. Press Enter when done"

Write-Host "DONE! First time: Enter for theme, log in, Yes to trust folder. Then type: /track"
Set-Location $Dir
claude --chrome
