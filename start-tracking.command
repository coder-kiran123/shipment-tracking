#!/bin/bash
# Daily: double-click this, then type /track
export PATH="$HOME/.local/bin:$PATH"
cd "$HOME/sirjan" && git pull -q 2>/dev/null; exec claude --chrome
