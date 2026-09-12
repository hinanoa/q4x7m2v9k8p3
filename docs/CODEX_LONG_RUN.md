# Codex long-run handoff

This file is the task contract for substantial autonomous Codex work. Keep the active objective bounded and verifiable; put generic delegation/publication details in their dedicated docs instead of repeating them here.

## Fixed launch instruction

```text
docs/CODEX_LONG_RUN.md の Current bounded objective を最後まで実行してください。AGENTS.md と project-long-run skill に従ってください。
```

For ChatGPT -> Codex delegation rules, use `docs/CHATGPT_CODEX_HANDOFF.md` only when preparing or continuing a handoff. For Codex Cloud publication, use `docs/CODEX_CLOUD_PUBLICATION.md` only when publication is relevant.

## Current bounded objective

**INACTIVE**

Do not start substantial autonomous implementation from this file while this section is inactive.

When activating it, replace `INACTIVE` with one objective containing only the task-specific contract:

- **Goal:** the concrete outcome required.
- **Scope:** files/components/features that may change.
- **Out of scope:** boundaries that matter for this task.
- **Authority:** only the specifications/docs that control this work.
- **Required implementation:** concrete deliverables.
- **Verification:** relevant local checks and any required human-only review.
- **Stopping condition:** objective evidence that defines completion.
- **Blockers:** conditions that justify stopping for user input.

Do not copy generic repository instructions into the objective. `AGENTS.md` and the matching skill already apply.

## Repair and continuation

If CI, review, or local verification exposes defects caused by the objective, diagnose related failures together, repair the same work branch, rerun the affected checks, and continue until the stopping condition is met or a genuine blocker is reached.

A first implementation is not the stopping condition when the objective also requires execution, inspection, repair, or validation.

## Parallel execution

Parallel Codex tasks are appropriate only when their write scopes are independent or an explicit integration plan exists. Keep each task's objective and completion condition separate.
