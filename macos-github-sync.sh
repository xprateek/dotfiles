#!/bin/bash
# Sync macOS to GitHub repo (rsync + git) - BEEM41
cd "$(git rev-parse --show-toplevel)"
MACOS_DIR="./macos"

# rsync: efficient incremental sync
rsync -av --delete ~/.bin/ "$MACOS_DIR/bin/"
rsync -av --delete ~/.config/ "$MACOS_DIR/" || true
rsync -av ~/.config/wezterm/wezterm.lua "$MACOS_DIR/wezterm/" || true

git add macos/
git commit -m "macOS rsync sync $(date +%Y-%m-%d)"
echo "✅ macOS synced to $MACOS_DIR"
