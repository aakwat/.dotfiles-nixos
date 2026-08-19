#!/usr/bin/env bash
# wallpaper-picker — text-only tofi picker for ~/Pictures/Wallpapers.
# (tofi has no thumbnail support; migrated from rofi's icon grid.)

set -euo pipefail

pgrep -x tofi >/dev/null 2>&1 && exec pkill -x tofi

DIR="$HOME/Pictures/Wallpapers"
[[ -d "$DIR" ]] || { notify-send "Wallpaper picker" "No directory: $DIR" 2>/dev/null; exit 1; }

declare -A MAP
menu=""
while IFS= read -r f; do
    label=$(basename "$f")
    n=1; key="$label"
    while [[ -n "${MAP[$key]:-}" ]]; do key="$label ($((++n)))"; done
    MAP[$key]="$f"
    menu+="${key}"$'\n'
done < <(find "$DIR" -type f \
            \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
            | sort)

[[ -n "$menu" ]] || { notify-send "Wallpaper picker" "No images in $DIR" 2>/dev/null; exit 1; }

choice=$(printf '%s' "$menu" | tofi --mode dmenu)
[[ -n "${choice:-}" ]] || exit 0
img="${MAP[$choice]:-}"
[[ -n "$img" && -f "$img" ]] && exec "$HOME/.local/bin/wallpaper" "$img"
