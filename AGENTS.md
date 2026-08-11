# Repository purpose

This repository is a lightweight personal distribution/configuration layer for reusable design skills used across multiple project repositories.

## Rules for changes

- Keep upstream versions pinned in `versions.env`; do not silently switch to floating `main` branches.
- Keep Hallmark and Apple HIG as user-level skills installed under `$HOME/.agents/skills`.
- Keep per-project visual direction separate: `scripts/use-design.sh` should copy a selected profile to the target project's `DESIGN.md`.
- Do not place a root `DESIGN.md` in this toolkit repo; it could be mistaken for the toolkit's own design direction.
- Prefer installer/configuration code over vendoring full upstream repositories.
- Preserve overwrite protection for an existing target `DESIGN.md` unless the user explicitly passes `--force`.
- When changing a pinned commit, verify the expected source paths still exist before updating the pin.

## Current source layout assumptions

- Hallmark: `skills/hallmark/SKILL.md` and `skills/hallmark/references/`
- HIGAgentSkills: `SKILL.md`, `routing-index.md`, and `distilled/`
- awesome-design-md: `design-md/<name>/DESIGN.md`
