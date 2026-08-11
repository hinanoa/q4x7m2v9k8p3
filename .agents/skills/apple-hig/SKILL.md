---
name: apple-hig
description: Use for Apple-platform interface design or review when high-level Apple interaction, hierarchy, accessibility, navigation, input, typography, and platform-convention guidance is useful.
---

# Apple platform interface checklist

This is an original compact checklist, not a redistributed copy of Apple Human Interface Guidelines or HIGAgentSkills.

- Prefer familiar platform behavior over custom interaction when a system pattern already solves the problem.
- Make hierarchy obvious through navigation, spacing, typography, grouping, and progressive disclosure rather than decorative chrome.
- Keep primary actions clear and avoid presenting many visually equal actions at once.
- Respect safe areas, system bars, keyboard/IME behavior, touch or pointer ergonomics, and platform-specific navigation conventions.
- Support scalable text where applicable; do not rely on fixed text sizes for critical content.
- Preserve sufficient contrast and never encode meaning using color alone.
- Provide accessible labels, logical focus order, meaningful roles, and alternatives for motion or gesture-only interactions.
- Prefer system components when they provide expected behavior, accessibility, localization, and state handling. Customize only when the product benefit is clear.
- Treat destructive actions distinctly and confirm consequences that are difficult to reverse.
- Avoid needless modal layers. Choose navigation, sheets, popovers, menus, or inline disclosure based on platform expectations.
- For forms, keep labels and validation close to the input, explain errors plainly, and preserve user-entered data after validation failures.
- Design loading, empty, offline, and error states so the user knows what happened and what to do next.
- On iPadOS/macOS, account for resizable windows, keyboard navigation, pointer interaction, and multi-column layouts where appropriate.
- On watchOS/tvOS/visionOS, design around the platform's input model and viewing conditions rather than porting an iPhone layout mechanically.

If an exact current measurement, API behavior, or newly changed Apple rule is essential and network access is available, verify against current Apple developer documentation instead of guessing.
