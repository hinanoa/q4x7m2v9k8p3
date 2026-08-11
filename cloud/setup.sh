#!/usr/bin/env bash
set -euo pipefail

TOOLKIT_REPO="${DESIGN_TOOLKIT_REPO:-hinanoa/q4x7m2v9k8p3}"
TOOLKIT_REF="${DESIGN_TOOLKIT_REF:-main}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
ARCHIVE="$TMP_DIR/toolkit.zip"
EXTRACT_DIR="$TMP_DIR/extracted"
mkdir -p "$EXTRACT_DIR"

if ! command -v curl >/dev/null 2>&1; then
  echo "Required command not found: curl" >&2
  exit 1
fi

echo "Fetching ${TOOLKIT_REPO}@${TOOLKIT_REF}" >&2
curl -fsSL \
  "https://github.com/${TOOLKIT_REPO}/archive/refs/heads/${TOOLKIT_REF}.zip" \
  -o "$ARCHIVE"

if command -v unzip >/dev/null 2>&1; then
  unzip -q "$ARCHIVE" -d "$EXTRACT_DIR"
elif command -v python3 >/dev/null 2>&1; then
  python3 - "$ARCHIVE" "$EXTRACT_DIR" <<'PY'
import sys, zipfile
archive, target = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(archive) as zf:
    zf.extractall(target)
PY
else
  echo "Need either unzip or python3 to extract the toolkit." >&2
  exit 1
fi

TOOLKIT_DIR="$(find "$EXTRACT_DIR" -mindepth 1 -maxdepth 1 -type d -print -quit)"
if [[ -z "$TOOLKIT_DIR" || ! -f "$TOOLKIT_DIR/scripts/install.sh" ]]; then
  echo "Toolkit archive did not contain scripts/install.sh" >&2
  exit 2
fi

bash "$TOOLKIT_DIR/scripts/install.sh"

echo "Codex Cloud toolkit bootstrap complete."
