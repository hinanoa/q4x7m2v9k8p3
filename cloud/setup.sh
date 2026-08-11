#!/usr/bin/env bash
set -euo pipefail

# Compatibility bootstrap for Codex Cloud Environments configured before this
# repository became a self-contained GitHub template. New repositories created
# from the template do not need this setup script.

BASE="https://raw.githubusercontent.com/hinanoa/q4x7m2v9k8p3/main"
SKILLS_DIR="${HOME}/.agents/skills"
CODEX_HOME_DIR="${CODEX_HOME:-${HOME}/.codex}"
mkdir -p "$SKILLS_DIR/hallmark/references" \
         "$SKILLS_DIR/design-toolkit/references" \
         "$SKILLS_DIR/apple-hig" \
         "$CODEX_HOME_DIR"

fetch() {
  local path="$1"
  local dest="$2"
  curl -fsSL "$BASE/$path" -o "$dest"
}

fetch ".agents/skills/hallmark/SKILL.md" "$SKILLS_DIR/hallmark/SKILL.md"
fetch ".agents/skills/hallmark/references/anti-generic.md" "$SKILLS_DIR/hallmark/references/anti-generic.md"
fetch ".agents/skills/hallmark/references/review-gates.md" "$SKILLS_DIR/hallmark/references/review-gates.md"
fetch ".agents/skills/design-toolkit/SKILL.md" "$SKILLS_DIR/design-toolkit/SKILL.md"
fetch ".agents/skills/design-toolkit/references/catalog.md" "$SKILLS_DIR/design-toolkit/references/catalog.md"
fetch ".agents/skills/design-toolkit/references/profiles.md" "$SKILLS_DIR/design-toolkit/references/profiles.md"
fetch ".agents/skills/apple-hig/SKILL.md" "$SKILLS_DIR/apple-hig/SKILL.md"
fetch "AGENTS.md" "$CODEX_HOME_DIR/AGENTS.md"

echo "Compatibility toolkit installed for this Codex Cloud Environment."
echo "New repositories created from the GitHub template need no setup script."
