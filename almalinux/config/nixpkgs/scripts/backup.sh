#!/bin/sh
set -e
D=~/.config/nixpkgs/backup
mkdir -p "$D"

# Nix CLI dev tools only
nix profile list | awk 'NR>2&&$3~/legacyPackages/{gsub(/.*\./,"",$3);print "nixpkgs#"$3}' | grep -E '(aria2|bun|cargo|dust|fping|ipinfo|lf|lolcat|lsd|micro|nodejs|nushell|oh-my-posh|speed|tgpt|tree|wush|scrcpy)' | sort -u > "$D/nix.txt"

# Brew CLI only
brew list 2>/dev/null | grep -E '^(fastfetch|fish|gh|git|ripgrep|fzf|bat|zoxide|fd)$' | sort -u > "$D/brew.txt" || touch "$D/brew.txt"

# DNF Critical system only
dnf history userinstalled 2>/dev/null | awk 'NR>2&&/cockpit|podman|docker|samba|tailscale|fuse/{print$1}' | sort -u > "$D/dnf.txt" || rpm -qa --last | head -50 | awk '{print$1}' | cut -d. -f1 | sort -u | grep -E '(cockpit|podman|docker|samba|tailscale|fuse)' > "$D/dnf.txt"

# Flatpak GUI only
flatpak list --app --columns=application 2>/dev/null | tail -n +3 | sort -u > "$D/flatpak.txt" || touch "$D/flatpak.txt"

echo "Backup: $(ls "$D" | wc -l) files"
