# Shipment Tracking (Maersk, CMA CGM, MSC)

Daily ETD/ETA update for shipments, using Claude Code + Claude in Chrome.

## Setup on a new PC
```
git clone <this repo url> ~/sirjan
```
Then follow [SETUP_NEW_PC.txt](SETUP_NEW_PC.txt) steps 2-5.

## Daily use
1. Save your Excel to Downloads as `tracking.xlsx`
2. `cd ~/sirjan && claude --chrome`
3. Type `/track`

Results are saved as `tracking_YYYY-MM-DD.csv` (not uploaded to GitHub).
