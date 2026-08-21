#!/usr/bin/env bash
# mango autostart — sourced at compositor start.
# Everything here runs in the background; parent script exits fast.

# Bar / notifications / idle / wallpaper daemon / IM / applet / xwayland
pgrep -x waybar             >/dev/null || waybar &
pgrep -x mako               >/dev/null || mako &
pgrep -x hypridle           >/dev/null || hypridle &
pgrep -x awww-daemon        >/dev/null || awww-daemon &
pgrep -x fcitx5             >/dev/null || fcitx5 -d &
pgrep -x nm-applet          >/dev/null || nm-applet --indicator &
pgrep -x xwayland-satellite >/dev/null || xwayland-satellite &

# Clipboard watchers
pgrep -f "cliphist store" >/dev/null || {
    wl-paste --type text  --watch cliphist store &
    wl-paste --type image --watch cliphist store &
}

# Polkit agent
systemctl --user list-unit-files hyprpolkitagent.service >/dev/null 2>&1 && \
    systemctl --user start hyprpolkitagent

# Wallpaper (needs daemon to be up first)
( sleep 0.5 && "$HOME/.local/bin/wallpaper" ) &

exit 0
