#!/bin/bash
# Script to list installed nix profile packages as nixpkgs#pkgname in a text file

OUTPUT_FILE="installed-packages.txt"

NO_COLOR=1 nix profile list | grep '^Name:' | awk '{print "nixpkgs#" $2}' > installed-packages.txt

echo "Package list saved to $OUTPUT_FILE"
