#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="${HOME}/.agents/skills"
DESIGN_HOME="${DESIGN_TOOLKIT_HOME:-${HOME}/.design-toolkit}"
CODEX_HOME_DIR="${CODEX_HOME:-${HOME}/.codex}"
GLOBAL_AGENTS="$CODEX_HOME_DIR/AGENTS.md"
GLOBAL_BEGIN='<!-- BEGIN my-design-toolkit:github-actions-budget -->'
GLOBAL_END='<!-- END my-design-toolkit:github-actions-budget -->'

rm -rf "$SKILLS_DIR/hallmark" "$SKILLS_DIR/apple-hig" "$SKILLS_DIR/design-toolkit" "$DESIGN_HOME"

echo "Removed user-level skills and design cache:"
echo "  $SKILLS_DIR/hallmark"
echo "  $SKILLS_DIR/apple-hig"
echo "  $SKILLS_DIR/design-toolkit"
echo "  $DESIGN_HOME"

if [[ -f "$GLOBAL_AGENTS" ]]; then
  tmp="$(mktemp)"
  trap 'rm -f "$tmp"' EXIT
  awk -v begin="$GLOBAL_BEGIN" -v end="$GLOBAL_END" '
    $0 == begin { skipping = 1; next }
    $0 == end { skipping = 0; next }
    !skipping { print }
  ' "$GLOBAL_AGENTS" > "$tmp"

  if [[ -s "$tmp" ]]; then
    mv "$tmp" "$GLOBAL_AGENTS"
    trap - EXIT
    echo "Removed toolkit guidance block from: $GLOBAL_AGENTS"
  else
    rm -f "$GLOBAL_AGENTS" "$tmp"
    trap - EXIT
    echo "Removed empty global guidance file: $GLOBAL_AGENTS"
  fi
fi
