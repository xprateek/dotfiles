#!/bin/sh
set -e
D=~/.config/nixpkgs/backup

echo "Restore DNF..."
[ -f "$D/dnf.txt" ] && sudo sh -c "cat '$D/dnf.txt' | grep -v '^$' | xargs dnf install -y" || true

echo "Restore Brew..."
[ -f "$D/brew.txt" ] && sh -c "cat '$D/brew.txt' | grep -v '^$' | xargs brew install" || true

echo "Restore Nix..."
[ -f "$D/nix.txt" ] && sh -c "cat '$D/nix.txt' | grep '^nixpkgs#' | xargs nix profile add" || true

echo "Restore Flatpak..."
[ -f "$D/flatpak.txt" ] && while read -r pkg; do 
  [ -n "$pkg" ] && flatpak list | grep "$pkg" >/dev/null 2>&1 || flatpak install -y "$pkg"
done < "$D/flatpak.txt" || true

echo "Restore done"
