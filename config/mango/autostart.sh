#!/usr/bin/env bash
# mango runs this at startup. Ported from niri spawn-at-startup.
waybar &
mako &
hypridle &
fcitx5 -d &
nm-applet --indicator &
awww-daemon &
systemctl --user start hyprpolkitagent &

wl-paste --type text  --watch cliphist store &
wl-paste --type image --watch cliphist store &

sleep 0.5 && "$HOME/.local/bin/wallpaper" &
