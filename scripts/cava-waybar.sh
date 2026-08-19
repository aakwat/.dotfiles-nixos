#!/usr/bin/env bash
# waybar custom/cava — music visualizer.
#
# Arch's `waybar` package is NOT compiled with the bundled `cava` module
# (waybar logs: `Disabling module "cava", Unknown module`). So instead we
# drive the standalone `cava` binary (pkg: cava) and translate its raw
# ascii output into bar glyphs that the `custom/cava` module renders.
#
# Wired up in .config/waybar/modules.json -> "custom/cava".exec
# Symlinked to ~/.local/bin/cava-waybar by the README install loop.

set -euo pipefail

BARS=12

# cava is installed at /usr/sbin on Arch — make sure it is on PATH.
export PATH="/usr/sbin:/usr/bin:$PATH"

if ! command -v cava >/dev/null 2>&1; then
    echo ""   # nothing to show; keep waybar happy
    exit 0
fi

CFG="$(mktemp)"
trap 'rm -f "$CFG"' EXIT

cat > "$CFG" <<EOF
[general]
framerate = 30
bars = $BARS

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
bar_delimiter = 59
EOF

# value 0..7  ->  ▁ ▂ ▃ ▄ ▅ ▆ ▇ █
GLYPHS=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

cava -p "$CFG" | while IFS=';' read -r -a vals; do
    line=""
    for n in "${vals[@]}"; do
        [[ -z "$n" ]] && continue          # trailing delimiter -> empty field
        line+="${GLYPHS[$n]}"
    done
    printf '%s\n' "$line"
done
