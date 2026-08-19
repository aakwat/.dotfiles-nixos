#!/usr/bin/env bash
# Delete ~/.config entries that block home-manager activation.
# Symlinks are never touched. No backups - run before the first rebuild.
set -uo pipefail

MANAGED=(niri waybar mako tofi kitty hypr gtk-3.0 gtk-4.0 yazi zellij nvim starship.toml)

removed=0
for d in "${MANAGED[@]}"; do
    p="$HOME/.config/$d"
    if [ -L "$p" ]; then
        printf '%-13s link -> %s\n' "$d" "$(readlink "$p")"
    elif [ -e "$p" ]; then
        rm -rf "$p"
        printf '%-13s removed\n' "$d"
        removed=$((removed + 1))
    fi
done

shopt -s nullglob
for b in "$HOME"/.config/*.hm-bak; do
    rm -rf "$b"
    printf '%-13s removed\n' "$(basename "$b")"
    removed=$((removed + 1))
done
shopt -u nullglob

echo "$removed removed"
