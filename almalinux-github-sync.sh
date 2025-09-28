#!/bin/bash
# Sync AlmaLinux to GitHub repo (rsync + git) - BEEL05
cd "$(git rev-parse --show-toplevel)"
ALMA_DIR="./almalinux"

# rsync: efficient incremental sync (no nesting)
rsync -av --delete ~/.bin/ "$ALMA_DIR/bin/"
rsync -av --delete ~/.config/fish/ "$ALMA_DIR/config/fish/" || true
rsync -av --delete ~/.config/micro/ "$ALMA_DIR/config/micro/" || true
rsync -av --delete ~/.config/nixpkgs/ "$ALMA_DIR/config/nixpkgs/" || true

git add almalinux/
git commit -m "AlmaLinux rsync sync $(date +%Y-%m-%d)"
echo "✅ AlmaLinux synced to $ALMA_DIR"
