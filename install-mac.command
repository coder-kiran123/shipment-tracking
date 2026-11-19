#!/bin/bash
# Shipment Tracking - setup for Mac.
# Run in Terminal:  bash ~/Downloads/install-mac.command
set -e
REPO="coder-kiran123/shipment-tracking"
DIR="$HOME/sirjan"
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
export PATH="$BIN:$PATH"
grep -q '.local/bin' ~/.zshrc 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

echo "== 1/5 Checking Google Chrome =="
if [ ! -d "/Applications/Google Chrome.app" ]; then
  echo "Chrome not found. Opening download page - install it, then run this file again."
  open "https://www.google.com/chrome/"; exit 1
fi

echo "== 2/5 Checking Apple developer tools (git) =="
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
  echo ">> A window opened: click Install and wait until it finishes."
  until xcode-select -p >/dev/null 2>&1; do sleep 10; done
fi

echo "== Installing Claude =="
command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash

echo "== 3/5 Installing GitHub tool =="
if ! command -v gh >/dev/null; then
  A=$(uname -m | sed 's/x86_64/amd64/'); T=$(mktemp -d)
  curl -fsSL -o "$T/gh.zip" "https://github.com/cli/cli/releases/download/v2.62.0/gh_2.62.0_macOS_${A}.zip"
  unzip -q "$T/gh.zip" -d "$T" && cp "$T"/gh_*/bin/gh "$BIN/gh"
fi
if ! gh auth status >/dev/null 2>&1; then
  echo ">> Log in to GitHub as coder-kiran123 (copy the code shown, browser will open)"
  gh auth login --web -h github.com -p https --git-protocol https
fi

echo "== 4/5 Downloading tracking system =="
if [ -d "$DIR/.git" ]; then (cd "$DIR" && git pull -q); else gh repo clone "$REPO" "$DIR"; fi

echo "== 5/5 Claude in Chrome extension =="
open -a "Google Chrome" "https://chromewebstore.google.com/search/Claude%20in%20Chrome"
echo ">> In Chrome: click 'Claude in Chrome' -> Add to Chrome -> Sign in."
read -p ">> Press Enter when the extension is installed..."

echo ""
echo "DONE! Starting Claude. First time: press Enter for theme, log in, choose Yes to trust folder."
echo "Then type:  /track"
cd "$DIR" && exec claude --chrome
