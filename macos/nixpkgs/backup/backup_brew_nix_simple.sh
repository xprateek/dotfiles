#!/usr/bin/env bash

set -euo pipefail

BACKUP_DIR="$HOME/.config/nixpkgs/backup"
mkdir -p "$BACKUP_DIR"

echo "Backing up Nix profile packages (names only)..."
nix profile list > "$BACKUP_DIR/nix_profile_packages.txt"

echo "Backing up nix-darwin installed packages (environment.systemPackages)..."
echo "Please manually backup nix-darwin systemPackages from your nixpkgs config or flake.nix" > "$BACKUP_DIR/nix_darwin_systemPackages_note.txt"

echo "Backing up Homebrew taps..."
brew tap > "$BACKUP_DIR/brew_taps.txt"

echo "Backing up Homebrew formulae..."
brew list --formula > "$BACKUP_DIR/brew_formulae.txt"

echo "Backing up Homebrew casks..."
brew list --cask > "$BACKUP_DIR/brew_casks.txt"

echo "Backing up Mac App Store installed apps using mas..."
if command -v mas &>/dev/null; then
  mas list > "$BACKUP_DIR/mas_installed_apps.txt"
else
  echo "mas command not found, skipping Mac App Store apps backup." > "$BACKUP_DIR/mas_backup_note.txt"
fi

echo "Backup completed."
echo "Saved files to: $BACKUP_DIR"
