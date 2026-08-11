---
name: design-toolkit
description: "Select, inspect, compare, and apply design references from the cached my-design-toolkit / awesome-design-md library. Use when the user mentions my-design-toolkit, the design library, DESIGN.md references, or asks to use a named reference style such as Linear, Apple, Stripe, Notion, Figma, Airbnb, or another library entry. Also use when the user asks for a less AI-looking UI and wants a concrete reference from the toolkit."
---

# Design Toolkit

Use the design reference library cached during environment setup. Do not depend on internet access during the agent phase.

## Locations

- Design library: `$HOME/.design-toolkit/design-library`
- Helper: `$HOME/.agents/skills/design-toolkit/scripts/use-design.sh`
- Hallmark skill: `$HOME/.agents/skills/hallmark`
- Apple HIG skill: `$HOME/.agents/skills/apple-hig`

## Workflow

1. If the user names a reference design, resolve it with:

   ```bash
   bash "$HOME/.agents/skills/design-toolkit/scripts/use-design.sh" --path "<design-name>"
   ```

   The helper accepts exact names and a unique case-insensitive partial match, so `linear` can resolve to `linear.app` when unambiguous.

2. Read the resolved `DESIGN.md` before changing the UI. Treat it as a visual reference and design vocabulary, not as permission to copy proprietary assets or product content.

3. If the user explicitly wants the reference applied to the current repository, install it at the repository root:

   ```bash
   bash "$HOME/.agents/skills/design-toolkit/scripts/use-design.sh" "<design-name>" .
   ```

   Never overwrite an existing `DESIGN.md` unless the user clearly intends replacement. Only then use `--force`.

4. If the user asks to use the toolkit but does not name a design, list the available references:

   ```bash
   bash "$HOME/.agents/skills/design-toolkit/scripts/use-design.sh" --list
   ```

   Inspect a small number of plausible candidates and choose the best fit from the product context. Do not read the entire library without a reason.

5. For implementation or redesign work, combine the selected `DESIGN.md` with Hallmark when appropriate to avoid generic AI-generated visual patterns. Use Apple HIG when the target is an Apple-platform interface or when Apple interaction conventions are specifically relevant.

6. Existing project-specific design requirements and repository instructions take priority over a generic library reference. Preserve accessibility, product requirements, and established component behavior.

## Prompt examples this skill should handle

- `my-design-toolkit の Linear 系を使って実装して`
- `デザインライブラリから Stripe を参考にして`
- `Hallmark と design-toolkit を使って AIっぽくないUIにして`
- `このプロダクトに合う DESIGN.md をライブラリから選んで`
