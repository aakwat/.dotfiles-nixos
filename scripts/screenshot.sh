#!/usr/bin/env bash
# screenshot helper — wraps grimblast + swappy
#
# Usage:
#   screenshot area         # region → clipboard + saved file
#   screenshot area-save    # region → saved file (+ clipboard)
#   screenshot area-edit    # region → swappy editor → saved file
#   screenshot screen       # full screen → saved file (+ clipboard)
#   screenshot screen-copy  # full screen → clipboard only
#
# Files are written to ~/Pictures/Screenshots/ so they show up in Nemo.
# (A clipboard image cannot be "pasted" into a file manager — only a real
# file can; that is why every mode except *-copy now also saves one.)

set -euo pipefail

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"

case "${1:-area}" in
    area)
        grimblast --notify copysave area "$FILE"
        ;;
    area-save)
        grimblast --notify copysave area "$FILE"
        ;;
    area-edit)
        grimblast save area "$FILE" && swappy -f "$FILE" -o "$FILE"
        ;;
    screen)
        grimblast --notify copysave screen "$FILE"
        ;;
    screen-copy)
        grimblast --notify copy screen
        ;;
    *)
        echo "unknown mode: $1" >&2
        echo "usage: screenshot [area|area-save|area-edit|screen|screen-copy]" >&2
        exit 1
        ;;
esac
