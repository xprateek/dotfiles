#!/bin/bash
# Script to list installed nix profile packages as nixpkgs#pkgname in a text file

OUTPUT_FILE="installed-packages.txt"

nix profile list | grep '^Name:' | awk '{print "nixpkgs#" $2}' > "$OUTPUT_FILE"

echo "Package list saved to $OUTPUT_FILE"
