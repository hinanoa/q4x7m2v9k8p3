---
name: design-toolkit
description: Use when the user asks to use, reference, compare, or choose a visual design language from the local design catalog, including named references such as Linear, Apple, Figma, Stripe, Notion, Airbnb, Vercel, Raycast, and others.
---

# Design toolkit

This repository contains a compact local design-reference catalog. No network access or setup script is required.

## Files

- `references/catalog.md`: all available reference names with palette and typography fingerprints.
- `references/profiles.md`: deeper, original summaries for frequently useful design directions.

## How to use

1. Resolve the user's reference name case-insensitively. Common aliases include `linear` → `linear.app`, `mistral` → `mistral.ai`, `opencode` → `opencode.ai`, and `x` → `x.ai`.
2. Read the matching catalog row.
3. If the reference has a profile in `profiles.md`, read that too.
4. Translate the visual language into the current product's information architecture and component system.
5. Combine with `hallmark` for implementation or redesign work unless the user explicitly wants a faithful generic/system look.

Do not reproduce brand logos, trademarks, copyrighted illustrations, or exact branded layouts. Color values and typography fingerprints are reference facts, not instructions to impersonate a brand.
