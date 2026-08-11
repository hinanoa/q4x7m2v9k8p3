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
CODEX_HOME_DIR="${CODEX_HOME:-${HOME}/.codex}"
GLOBAL_AGENTS="$CODEX_HOME_DIR/AGENTS.md"
GLOBAL_SOURCE="$ROOT_DIR/global/AGENTS.md"
GLOBAL_BEGIN='<!-- BEGIN my-design-toolkit:github-actions-budget -->'
GLOBAL_END='<!-- END my-design-toolkit:github-actions-budget -->'

mkdir -p "$SKILLS_DIR" "$CODEX_HOME_DIR"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

fetch_repo() {
  local repo="$1"
  local commit="$2"
  local key="$3"
  local zip_path="$TMP_DIR/${key}.zip"
  local out_dir="$TMP_DIR/${key}"

  mkdir -p "$out_dir"
  echo "Fetching ${repo}@${commit}" >&2
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

install_global_agents() {
  if [[ ! -f "$GLOBAL_SOURCE" ]]; then
    echo "Global AGENTS source was not found: $GLOBAL_SOURCE" >&2
    exit 2
  fi

  local cleaned="$TMP_DIR/global-agents-cleaned.md"
  : > "$cleaned"

  if [[ -f "$GLOBAL_AGENTS" ]]; then
    awk -v begin="$GLOBAL_BEGIN" -v end="$GLOBAL_END" '
      $0 == begin { skipping = 1; next }
      $0 == end { skipping = 0; next }
      !skipping { print }
    ' "$GLOBAL_AGENTS" > "$cleaned"
  fi

  {
    cat "$cleaned"
    if [[ -s "$cleaned" ]]; then
      printf '\n'
    fi
    printf '%s\n' "$GLOBAL_BEGIN"
    cat "$GLOBAL_SOURCE"
    printf '\n%s\n' "$GLOBAL_END"
  } > "$GLOBAL_AGENTS"

  echo "Installed global Codex guidance -> $GLOBAL_AGENTS"

  if [[ -s "$CODEX_HOME_DIR/AGENTS.override.md" ]]; then
    echo "WARNING: $CODEX_HOME_DIR/AGENTS.override.md exists and takes precedence over AGENTS.md." >&2
    echo "The toolkit guidance will not be active until that override is removed or updated." >&2
  fi
}

install_hallmark
install_hig
install_global_agents

echo
echo "Installed user-level Codex resources:"
echo "  $SKILLS_DIR/hallmark"
echo "  $SKILLS_DIR/apple-hig"
echo "  $GLOBAL_AGENTS"
echo
echo "Restart Codex so a new session rebuilds its instruction chain."
