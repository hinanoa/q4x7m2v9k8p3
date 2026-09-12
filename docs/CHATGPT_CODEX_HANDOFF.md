# ChatGPT -> Codex handoff

Load this document only when ChatGPT has decided to delegate implementation to Codex or when handling the publication/review continuation of such a task.

## Delegation

When ChatGPT decides that implementation should be delegated to Codex, the user-facing response begins with the exact sentence:

```text
codexに投げるべきと判断しました。
```

Immediately follow it with a complete ready-to-paste instruction. Include only what the task needs:

- repository and target branch/base when relevant;
- authoritative docs that actually control the requested area;
- goal and measurable completion condition;
- allowed scope and important out-of-scope boundaries;
- required implementation and relevant local verification;
- GitHub Actions budget constraints when hosted checks may run; and
- expected publication/PR handoff.

Do not make the prompt re-read unrelated repository documentation or reproduce generic guidance already supplied by `AGENTS.md` or a matching skill.

When independent write scopes make safe parallelism possible, split them into clearly named prompts that may run concurrently. Do not parallelize tasks that will race on the same foundation without an integration plan.

## Publication

For Codex Cloud, the task should complete implementation, relevant local verification, self-review, and a coherent commit before publication. At publication time, follow `docs/CODEX_CLOUD_PUBLICATION.md`.

- Use a callable native Codex PR/publish path when available.
- Otherwise return the documented `PUBLICATION_PENDING_UI` handoff with branch/worktree, commit SHA, intended base, proposed PR title/body, verification results, and exact blocker.
- Do not spend task time manufacturing an `origin`, repairing unavailable GitHub authentication, or repeatedly retrying a known sandbox publication limitation.
- Never invent a PR URL.

For local/CLI Codex with a genuinely authenticated remote, use the normal commit -> push -> create/update PR -> PR URL handoff.

## After publication

Once a PR is GitHub-visible, ChatGPT should normally inspect the diff, checks, and review state; consolidate routine repairs on the same PR; and merge when appropriate and authorized instead of using the user as a relay.

GitHub monitoring sees only GitHub-visible state. A `PUBLICATION_PENDING_UI` task is not monitorable until it is published. Do not imply that GitHub monitoring launched a new Codex task unless an actual task-launch capability was used.
