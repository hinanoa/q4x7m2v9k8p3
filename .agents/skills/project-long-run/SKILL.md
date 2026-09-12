---
name: project-long-run
description: Execute an active bounded objective in docs/CODEX_LONG_RUN.md end-to-end. Use only for substantial autonomous work with a defined stopping condition.
---

# Project long-run

Use `docs/CODEX_LONG_RUN.md` as the task contract. If its `Current bounded objective` is inactive or lacks an objective completion condition, do not invent one unless the user asked you to establish it.

## Load only what the objective needs

- Follow `AGENTS.md`.
- Read the authoritative project/specification docs named by the active objective and any additional source files needed for the requested area.
- Do not preload a fixed repository map or unrelated architecture/product/reference docs.
- Load `docs/CODEX_CLOUD_PUBLICATION.md` only when publication is actually being attempted.

## Execute to the stated stopping condition

Implement the complete bounded objective, run the relevant local verification required by the objective/repository, repair failures caused by the work, review the final diff, and commit coherently.

Do not stop after scaffolding or the first implementation if the objective explicitly requires running, inspecting, repairing, or verifying the result. Do not extend beyond the stated scope merely to be thorough.

Resolve routine implementation decisions from the repository, relevant docs, and tests. Stop only for a genuine external blocker, an unauthorized destructive/irreversible operation, irreconcilable authoritative requirements, or a required product/specification decision that cannot safely be inferred.

## Subagent discipline

Default to the primary agent. Use subagents only for clearly beneficial independent parallel work or specialized investigation, with distinct non-overlapping scopes. Do not duplicate an unfinished task across agents.

Once a subagent is running, prefer its completion notification/event over status polling. Do not repeatedly call wait/status/check at short intervals. If a timeout is necessary, use a long task-appropriate timeout (at least 120 seconds when no better estimate exists); after a timeout, do not immediately poll again. Continue useful parent work or wait a comparable/longer interval before rechecking. Do not launch a replacement merely because the original agent is still working.

Hosted CI is not an iterative debugger. Follow the GitHub Actions budget in `AGENTS.md` and use one publication/update per completed repair cycle by default.

At completion, report the actual verification performed, branch/commit/PR state, and any remaining blocker or human-only review requirement. Never claim a check that was not run.
