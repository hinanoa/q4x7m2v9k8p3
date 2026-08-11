#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="${HOME}/.agents/skills"
rm -rf "$SKILLS_DIR/hallmark" "$SKILLS_DIR/apple-hig"

echo "Removed:"
echo "  $SKILLS_DIR/hallmark"
echo "  $SKILLS_DIR/apple-hig"
