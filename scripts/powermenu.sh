#!/usr/bin/env bash
# powermenu — tofi-driven power options (second press closes open tofi)
set -euo pipefail

pgrep -x tofi >/dev/null 2>&1 && exec pkill -x tofi

CHOICE=$(printf "  Lock\n  Logout\n  Reboot\n  Shutdown\n󰒲  Suspend\n" \
    | tofi --mode dmenu --algorithm fuzzy)

case "$CHOICE" in
    *Lock*)     command -v hyprlock >/dev/null && hyprlock || loginctl lock-session ;;
    *Logout*)   niri msg action quit ;;
    *Reboot*)   systemctl reboot ;;
    *Shutdown*) systemctl poweroff ;;
    *Suspend*)  systemctl suspend ;;
esac
