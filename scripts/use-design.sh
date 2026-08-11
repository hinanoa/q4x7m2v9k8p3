#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=/dev/null
source "$ROOT_DIR/versions.env"

INSTALLED_HELPER="${HOME}/.agents/skills/design-toolkit/scripts/use-design.sh"
if [[ -f "$INSTALLED_HELPER" && -d "${DESIGN_TOOLKIT_HOME:-${HOME}/.design-toolkit}/design-library" ]]; then
  exec bash "$INSTALLED_HELPER" "$@"
fi

for cmd in curl unzip; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Required command not found: $cmd" >&2
    exit 1
  fi
done

CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/my-design-toolkit"
ARCHIVE="$CACHE_DIR/awesome-design-md-${DESIGN_COMMIT}.zip"

ensure_archive() {
  mkdir -p "$CACHE_DIR"
  if [[ ! -f "$ARCHIVE" ]]; then
    local tmp_archive="${ARCHIVE}.tmp"
    echo "Fetching ${DESIGN_REPO}@${DESIGN_COMMIT}" >&2
    rm -f "$tmp_archive"
    curl -fsSL "https://github.com/${DESIGN_REPO}/archive/${DESIGN_COMMIT}.zip" -o "$tmp_archive"
    mv "$tmp_archive" "$ARCHIVE"
  fi
}

list_designs() {
  ensure_archive
  unzip -Z1 "$ARCHIVE" \
    | sed -n 's#^.*/design-md/\([^/]*\)/DESIGN\.md$#\1#p' \
    | sort
}

usage() {
  cat <<'USAGE'
Usage:
  bash scripts/use-design.sh --list
  bash scripts/use-design.sh <design-name> [target-repo] [--force]

Examples:
  bash scripts/use-design.sh --list
  bash scripts/use-design.sh apple ~/GitHub/my-app
  bash scripts/use-design.sh linear.app .
  bash scripts/use-design.sh apple ~/GitHub/my-app --force
USAGE
}

if [[ "${1:-}" == "--list" ]]; then
  list_designs
  exit 0
fi

if [[ $# -lt 1 || $# -gt 3 ]]; then
  usage
  exit 1
fi

design="$1"
target="${2:-.}"
force="${3:-}"

if [[ -n "$force" && "$force" != "--force" ]]; then
  usage
  exit 1
fi

ensure_archive

source_path="$(unzip -Z1 "$ARCHIVE" | grep -F "/design-md/${design}/DESIGN.md" | head -n 1 || true)"
if [[ -z "$source_path" ]]; then
  echo "Unknown design: $design" >&2
  echo "Run: bash scripts/use-design.sh --list" >&2
  exit 2
fi

mkdir -p "$target"
destination="$target/DESIGN.md"

if [[ -f "$destination" && "$force" != "--force" ]]; then
  echo "Refusing to overwrite existing file: $destination" >&2
  echo "Re-run with --force if replacement is intentional." >&2
  exit 3
fi

unzip -p "$ARCHIVE" "$source_path" > "$destination"
echo "Applied design '$design' -> $destination"
