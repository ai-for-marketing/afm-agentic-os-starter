#!/usr/bin/env bash
# AFM Agentic OS — starter installer (sawdust-stub, v0.1).
# Portable: copies the method doc + the self-looping /goal into a destination dir and
# prints the next step. Does NOT touch ~/.claude or install skills — this is the recipe,
# not the working harness. Override the destination with AFM_STARTER_DIR=...
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${AFM_STARTER_DIR:-$HOME/afm-agentic-os}"

if [ ! -f "$HERE/AFM-BUILD-OS.md" ] || [ ! -f "$HERE/master-goal-prompt.txt" ]; then
  echo "ERROR: AFM-BUILD-OS.md / master-goal-prompt.txt missing next to this script." >&2
  echo "       Run this from the starter directory: bash install.sh" >&2
  exit 1
fi

mkdir -p "$DEST"
cp "$HERE/AFM-BUILD-OS.md" "$DEST/"
cp "$HERE/master-goal-prompt.txt" "$DEST/"
cp "$HERE/README.md" "$DEST/"

echo "AFM Agentic OS starter installed -> $DEST"
echo ""
echo "Next steps:"
echo "  1. Open  $DEST/master-goal-prompt.txt"
echo "  2. Copy the whole /goal ... block"
echo "  3. Paste it into your Claude Code / Codex / Gemini session IN the project you want to build"
echo "  4. The commander loop self-localises to that project + runs"
echo ""
echo "Installed the STARTER (method + loop). For the full integrated harness (skills, conduct"
echo "loops, watchdog, vault, GridOS), see README.md."
