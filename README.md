# Shipment Tracking (Maersk, CMA CGM, MSC)

Daily ETD/ETA update for shipments, using Claude Code + Claude in Chrome.

## Setup on a new PC (one line)
**Mac** - open Terminal and paste:
```
curl -fsSL https://raw.githubusercontent.com/coder-kiran123/shipment-tracking/main/install-mac.command | bash
```
**Windows** - open PowerShell and paste:
```
irm https://raw.githubusercontent.com/coder-kiran123/shipment-tracking/main/install-windows.ps1 | iex
```
Then click "Add to Chrome" for Claude in Chrome when asked, and type `/track`.

Manual steps: [SETUP_NEW_PC.txt](SETUP_NEW_PC.txt)

## Daily use
1. Save your Excel to Downloads as `tracking.xlsx`
2. Mac: double-click `start-tracking.command` (or `cd ~/sirjan && claude --chrome`)
3. Type `/track`

Results are saved as `tracking_YYYY-MM-DD.csv` (not uploaded to GitHub).
