#!/usr/bin/env bash
# wallpaper — set & PERSIST the desktop wallpaper (no auto shuffle).
#
# The last wallpaper you pick is saved to a state file and restored on every
# login, so it stays put across reboots. Random is only ever done when you
# explicitly ask for it (`--random`), never automatically.
#
# Works with either `swww` (upstream) or `awww` (Arch fork — same binary).
#
# Usage:
#   wallpaper                    # restore the saved wallpaper (login default)
#   wallpaper /path/to/file.png  # set this one and remember it
#   wallpaper --random | -r      # pick a new random one and remember it

set -euo pipefail

DIR="$HOME/Pictures/Wallpapers"
DEFAULT="$DIR/wallhaven-2e2xyx.jpg"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}"
STATE="$STATE_DIR/wallpaper"

list_images() {
    find "$DIR" -type f \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
        | sort
}

# Pick the daemon — prefer swww.
if   command -v swww-daemon >/dev/null 2>&1; then wp=swww
elif command -v awww-daemon >/dev/null 2>&1; then wp=awww
else
    echo "no swww/awww — add it to modules/system/packages.nix" >&2
    exit 1
fi

# Decide which image to show.
mode="${1:-restore}"
case "$mode" in
    -r|--random)
        [[ -d "$DIR" ]] || { echo "no $DIR" >&2; exit 1; }
        img=$(list_images | shuf -n 1)
        ;;
    restore)
        # Saved wallpaper wins; otherwise $DEFAULT, otherwise the first image.
        if [[ -s "$STATE" ]] && img=$(<"$STATE") && [[ -f "$img" ]]; then
            :
        elif [[ -f "$DEFAULT" ]]; then
            img="$DEFAULT"
        else
            [[ -d "$DIR" ]] || { echo "no $DIR" >&2; exit 1; }
            img=$(list_images | head -n 1)
        fi
        ;;
    *)
        [[ -f "$mode" ]] || { echo "no such image: $mode" >&2; exit 1; }
        img="$mode"
        ;;
esac

[[ -n "${img:-}" && -f "$img" ]] || { echo "no image found" >&2; exit 1; }

# Remember the choice so it survives reboots (skip on plain restore).
if [[ "$mode" != "restore" ]]; then
    mkdir -p "$STATE_DIR"
    printf '%s\n' "$img" > "$STATE"
fi

# Start daemon if not already running; wait up to ~3s for its socket.
pgrep -x "${wp}-daemon" >/dev/null || setsid -f "${wp}-daemon" >/dev/null 2>&1
for _ in {1..15}; do "$wp" query >/dev/null 2>&1 && break; sleep 0.2; done

exec "$wp" img "$img" \
    --transition-type any \
    --transition-fps 60 \
    --transition-duration 1 \
    --transition-bezier .43,1.19,1,.4
