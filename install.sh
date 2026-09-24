#!/usr/bin/env bash
# AFM Agentic OS — starter installer (v0.1).
#
# Copies the method doc + the self-looping /goal prompt into a folder in your home
# directory and prints the next step. It does NOT touch ~/.claude, install skills,
# need sudo, or contact any server other than GitHub (and only when the files are
# not already next to this script).
#
# Works on Ubuntu/Debian and macOS with the stock bash (3.2+).
#
# Usage:
#   bash install.sh                  # from a cloned or unzipped copy of this repo
#   bash install.sh --dir PATH       # install somewhere else
#   curl -fsSL <raw-url>/install.sh | bash   # without cloning; downloads the files
#
# Environment overrides:
#   AFM_STARTER_DIR   destination folder (default: ~/afm-agentic-os)
#   AFM_STARTER_REF   git branch/tag to download from when not run from a copy (default: master)

# Re-run under bash if started with plain `sh` (dash on Ubuntu has no pipefail).
if [ -z "${BASH_VERSION:-}" ]; then
  if [ -f "$0" ]; then
    exec bash "$0" "$@"
  fi
  echo "ERROR: please run this with bash, e.g.  bash install.sh" >&2
  exit 1
fi

set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/ai-for-marketing/afm-agentic-os-starter"
REF="${AFM_STARTER_REF:-master}"
FILES="AFM-BUILD-OS.md master-goal-prompt.txt README.md"
DEST="${AFM_STARTER_DIR:-}"

usage() {
  sed -n '2,19p' "${BASH_SOURCE[0]:-install.sh}" 2>/dev/null | sed 's/^# \{0,1\}//' ||
    echo "Usage: bash install.sh [--dir PATH]"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --dir)
      [ $# -ge 2 ] || { echo "ERROR: --dir needs a path" >&2; exit 1; }
      DEST="$2"; shift 2 ;;
    --dir=*) DEST="${1#--dir=}"; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "ERROR: unknown option: $1 (try --help)" >&2; exit 1 ;;
  esac
done

if [ -z "$DEST" ]; then
  if [ -z "${HOME:-}" ]; then
    echo "ERROR: HOME is not set; pass --dir PATH" >&2
    exit 1
  fi
  DEST="$HOME/afm-agentic-os"
fi

# Where are the source files? Next to this script if it was run from a copy of the repo.
SRC=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [ -f "$HERE/AFM-BUILD-OS.md" ] && [ -f "$HERE/master-goal-prompt.txt" ]; then
    SRC="$HERE"
  fi
fi

TMP=""
cleanup() { if [ -n "$TMP" ]; then rm -rf "$TMP"; fi; }
trap cleanup EXIT

download() { # url dest
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$1" -o "$2"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$2" "$1"
  else
    echo "ERROR: need curl or wget to download the starter files." >&2
    echo "       Ubuntu/Debian: sudo apt-get install -y curl   (macOS has curl built in)" >&2
    echo "       Or download the repository ZIP from GitHub, unzip it and run: bash install.sh" >&2
    exit 1
  fi
}

if [ -z "$SRC" ]; then
  echo "Starter files not found next to this script; downloading them from GitHub ($REF)..."
  TMP="$(mktemp -d 2>/dev/null || mktemp -d -t afm-starter)"
  for f in $FILES; do
    if ! download "$REPO_RAW/$REF/$f" "$TMP/$f"; then
      echo "ERROR: could not download $f. Check your internet connection and try again." >&2
      exit 1
    fi
  done
  SRC="$TMP"
fi

mkdir -p "$DEST"
for f in $FILES; do
  [ -f "$SRC/$f" ] || continue
  # Keep a backup if the user edited a previously installed copy.
  if [ -f "$DEST/$f" ] && ! cmp -s "$SRC/$f" "$DEST/$f"; then
    cp "$DEST/$f" "$DEST/$f.bak"
    echo "Kept your previous $f as $f.bak"
  fi
  cp "$SRC/$f" "$DEST/$f"
done

echo "AFM Agentic OS starter installed -> $DEST"
echo ""
echo "Next steps:"
echo "  1. Open  $DEST/master-goal-prompt.txt"
echo "  2. Copy the whole file (it starts with /goal)"
echo "  3. In a terminal, go into the project you want to build and start your AI coding tool"
echo "     (Claude Code: claude, Codex: codex, Gemini: gemini)"
echo "  4. Paste it and press Enter. The loop works out which project it is in and runs."
echo ""
echo "This is the STARTER (method + loop). For the full integrated harness (skills, conduct"
echo "loops, watchdog, vault, GridOS), see README.md."
