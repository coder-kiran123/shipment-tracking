@echo off
REM Daily shipment tracking: double-click this file, then type /track
cd /d "%USERPROFILE%\sirjan"
git pull -q 2>nul
"%USERPROFILE%\.local\bin\claude.exe" --chrome
pause
