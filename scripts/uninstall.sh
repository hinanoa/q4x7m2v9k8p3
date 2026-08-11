#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="${HOME}/.agents/skills"
CODEX_HOME_DIR="${CODEX_HOME:-${HOME}/.codex}"
GLOBAL_AGENTS="$CODEX_HOME_DIR/AGENTS.md"
GLOBAL_BEGIN='<!-- BEGIN my-design-toolkit:github-actions-budget -->'
GLOBAL_END='<!-- END my-design-toolkit:github-actions-budget -->'

rm -rf "$SKILLS_DIR/hallmark" "$SKILLS_DIR/apple-hig"

if [[ -f "$GLOBAL_AGENTS" ]]; then
  tmp_file="$(mktemp)"
  trap 'rm -f "$tmp_file"' EXIT

  awk -v begin="$GLOBAL_BEGIN" -v end="$GLOBAL_END" '
    $0 == begin { skipping = 1; next }
    $0 == end { skipping = 0; next }
    !skipping { print }
  ' "$GLOBAL_AGENTS" > "$tmp_file"

  if grep -q '[^[:space:]]' "$tmp_file"; then
    mv "$tmp_file" "$GLOBAL_AGENTS"
  else
    rm -f "$GLOBAL_AGENTS" "$tmp_file"
  fi
fi

echo "Removed toolkit-managed resources:"
echo "  $SKILLS_DIR/hallmark"
echo "  $SKILLS_DIR/apple-hig"
echo "  managed GitHub Actions budget block from $GLOBAL_AGENTS"
