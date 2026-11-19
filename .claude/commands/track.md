---
description: Update ETD/ETA for all shipments from Maersk, CMA CGM and MSC websites
---
Daily shipment tracking update.

1. Find the newest tracking Excel file: check ~/Downloads and this folder for `tracking*.xlsx` (use the most recently modified one). If the user gave a file path in $ARGUMENTS, use that instead.
2. Read every shipment row where Carrier is Maersk, CMA CGM or MSC. Use the BL No column (Maersk: the 9-digit number; CMA CGM: OEA...; MSC: MEDU...). Excel dates may be stored as serial numbers and may have day/month swapped — treat the carrier website as the truth.
3. Using Claude in Chrome, open each carrier's tracking page and read the current ETD (departure from loading port) and ETA (arrival at discharge port):
   - Maersk: https://www.maersk.com/tracking/<BL>
   - CMA CGM: https://www.cma-cgm.com/ebusiness/tracking/search?SearchBy=BL&Reference=<BL>
   - MSC: https://www.msc.com/en/track-a-shipment?agencyPath=msc&trackingNumber=<BL>
   If a robot check appears, stop and ask the user to solve it in Chrome. Never guess a date; write "Not found" if the page has none.
4. Write results to `tracking_YYYY-MM-DD.csv` in this folder (today's date) with columns: ID, Carrier, BL No, Loading, Discharge, Tracking Link, Old ETD, Old ETA, NEW ETD, NEW ETA, Changed. Dates as DD/MM/YYYY.
5. Reply in simple English with a short table of ONLY the shipments whose ETD or ETA changed (old → new, and how many days earlier/later), plus any "Not found" rows.
