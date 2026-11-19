# Shipment Tracking (Maersk, CMA CGM, MSC)

Daily ETD/ETA update for shipments, using Claude Code + Claude in Chrome.

## Setup on a new PC (one click)
1. On github.com (logged in as coder-kiran123) open this repo and download the installer:
   - **Mac:** download `install-mac.command`, open Terminal and run: `bash ~/Downloads/install-mac.command`
   - **Windows:** `install-windows.ps1` -> right-click -> Run with PowerShell
2. Follow the 2 prompts: GitHub login code, and "Add to Chrome" for Claude in Chrome.
3. Type `/track`.

Manual steps: [SETUP_NEW_PC.txt](SETUP_NEW_PC.txt)

## Daily use
1. Save your Excel to Downloads as `tracking.xlsx`
2. Mac: double-click `start-tracking.command` (or `cd ~/sirjan && claude --chrome`)
3. Type `/track`

Results are saved as `tracking_YYYY-MM-DD.csv` (not uploaded to GitHub).
