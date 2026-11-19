#!/bin/bash
# Shipment Tracking - setup for Mac.
# Run in Terminal:
#   curl -fsSL https://raw.githubusercontent.com/coder-kiran123/shipment-tracking/main/install-mac.command | bash
set -e
REPO="coder-kiran123/shipment-tracking"
DIR="$HOME/sirjan"
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
export PATH="$BIN:$PATH"
grep -q '.local/bin' ~/.zshrc 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

echo "== 1/4 Checking Google Chrome =="
if [ ! -d "/Applications/Google Chrome.app" ]; then
  echo "Chrome not found. Opening download page - install it, then run this file again."
  open "https://www.google.com/chrome/"; exit 1
fi

echo "== 2/4 Checking Apple developer tools (git) =="
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
  echo ">> A window opened: click Install and wait until it finishes."
  until xcode-select -p >/dev/null 2>&1; do sleep 10; done
fi

echo "== Installing Claude =="
command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash

echo "== 3/4 Downloading tracking system =="
if [ -d "$DIR/.git" ]; then (cd "$DIR" && git pull -q); else git clone -q "https://github.com/$REPO.git" "$DIR"; fi

echo "== 4/4 Claude in Chrome extension =="
open -a "Google Chrome" "https://chromewebstore.google.com/search/Claude%20in%20Chrome"
echo ">> In Chrome: click 'Claude in Chrome' -> Add to Chrome -> Sign in."
read -p ">> Press Enter when the extension is installed..." < /dev/tty

echo ""
echo "DONE! Starting Claude. First time: press Enter for theme, log in, choose Yes to trust folder."
echo "Then type:  /track"
cd "$DIR" && exec claude --chrome < /dev/tty
