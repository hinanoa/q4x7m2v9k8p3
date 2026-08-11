#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=/dev/null
source "$ROOT_DIR/versions.env"

for cmd in curl unzip; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Required command not found: $cmd" >&2
    exit 1
  fi
done

SKILLS_DIR="${HOME}/.agents/skills"
mkdir -p "$SKILLS_DIR"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

fetch_repo() {
  local repo="$1"
  local commit="$2"
  local key="$3"
  local zip_path="$TMP_DIR/${key}.zip"
  local out_dir="$TMP_DIR/${key}"

  mkdir -p "$out_dir"
  echo "Fetching ${repo}@${commit}"
  curl -fsSL "https://github.com/${repo}/archive/${commit}.zip" -o "$zip_path"
  unzip -q "$zip_path" -d "$out_dir"

  find "$out_dir" -mindepth 1 -maxdepth 1 -type d -print -quit
}

install_hallmark() {
  local src_root
  src_root="$(fetch_repo "$HALLMARK_REPO" "$HALLMARK_COMMIT" hallmark)"

  if [[ ! -f "$src_root/skills/hallmark/SKILL.md" ]]; then
    echo "Hallmark SKILL.md was not found in the pinned snapshot." >&2
    exit 2
  fi

  rm -rf "$SKILLS_DIR/hallmark"
  cp -R "$src_root/skills/hallmark" "$SKILLS_DIR/hallmark"
  echo "Installed Hallmark -> $SKILLS_DIR/hallmark"
}

install_hig() {
  local src_root
  src_root="$(fetch_repo "$HIG_REPO" "$HIG_COMMIT" apple-hig)"

  if [[ ! -f "$src_root/SKILL.md" || ! -d "$src_root/distilled" ]]; then
    echo "Apple HIG skill files were not found in the pinned snapshot." >&2
    exit 2
  fi

  rm -rf "$SKILLS_DIR/apple-hig"
  mkdir -p "$SKILLS_DIR/apple-hig"
  cp "$src_root/SKILL.md" "$SKILLS_DIR/apple-hig/"
  cp "$src_root/routing-index.md" "$SKILLS_DIR/apple-hig/"
  [[ -f "$src_root/README.md" ]] && cp "$src_root/README.md" "$SKILLS_DIR/apple-hig/"
  cp -R "$src_root/distilled" "$SKILLS_DIR/apple-hig/distilled"
  echo "Installed Apple HIG -> $SKILLS_DIR/apple-hig"
}

install_hallmark
install_hig

echo
echo "Installed user-level Codex skills:"
echo "  $SKILLS_DIR/hallmark"
echo "  $SKILLS_DIR/apple-hig"
echo
echo "Codex should detect skill changes automatically. Restart Codex if they do not appear."
