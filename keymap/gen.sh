#!/bin/sh
# Generate keymap data for tk46v6b with keymap-drawer.
#
#   pip install keymap-drawer
#   ./keymap/gen.sh           keymap/tk46v6b.yaml  (legends per layer)
#   ./keymap/gen.sh --draw    ...and docs/keymap.svg (chart drawn from tk46v6.dtsi)
#
# The physical layout lives in config/boards/shields/tk46v6/tk46v6.dtsi;
# this script only reads it.
set -e
cd "$(dirname "$0")/.."

SHIELD=config/boards/shields/tk46v6
KEYMAP=$SHIELD/tk46v6.keymap
DTSI=$SHIELD/tk46v6.dtsi
CFG=keymap/config.yaml
OUT=keymap/tk46v6b.yaml
SVG=docs/keymap.svg

command -v keymap >/dev/null || { echo "keymap-drawer not found: pip install keymap-drawer" >&2; exit 1; }

# Layer names must match the layer-key legends (Lower/Raise) in config.yaml.
keymap -c "$CFG" parse -z "$KEYMAP" -c 12 -l US JA Lower Raise Adjust -o "$OUT"

# Point the layout at the dtsi with a repo-relative path (no machine-specific paths).
sed -i.bak "s|^layout: .*|layout: {dts_layout: $DTSI}|" "$OUT" && rm -f "$OUT.bak"
echo "wrote $OUT"

if [ "$1" = "--draw" ]; then
  keymap -c "$CFG" draw "$OUT" -o "$SVG"
  echo "wrote $SVG"
fi
