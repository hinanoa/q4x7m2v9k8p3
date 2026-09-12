# Repository-wide agent instructions

Keep always-on guidance small. Load detailed workflow or domain documentation only when the current task needs it.

## Task routing and authority

- The user's current explicit instructions take precedence over generic skill/workflow guidance. Follow the repository's authoritative specifications for everything the user has not explicitly changed. Repository security, privacy, data-integrity, release, and product invariants remain hard boundaries unless the user explicitly changes the controlling specification.
- Inspect the files needed to understand the requested change. Do not read a fixed stack of architecture, deployment, product, or workflow documents before every edit.
- When a repository document is named as authoritative for the area being changed, use it. Do not load unrelated reference material merely because it exists.
- Resolve routine implementation choices from the codebase, relevant docs, and tests without asking for approval. Stop only for a genuine blocker, an unauthorized destructive/irreversible operation, or a product/specification decision that cannot safely be inferred.

## Subagent budget and waiting

Default to single-agent execution. Do not spawn subagents for routine repository inspection, file reading, status checks, simple research, sequential work, or changes the primary agent can complete directly.

Spawn the minimum number of subagents only when the user explicitly requests parallel agents or when independent parallel work/specialized investigation has a clear expected benefit that outweighs the additional token and context cost. Give each subagent a distinct non-overlapping scope and concrete deliverable. Do not spawn duplicate reviewer/research agents for the same question, and do not replace a usable/running subagent by launching another one without concrete evidence that it failed or is blocked.

After spawning a subagent, prefer completion notifications/events over polling. Do not repeatedly call wait/status/check at short intervals while the same subagent is still running. If an explicit timeout is unavoidable, use a long timeout appropriate to the task (default at least 120 seconds when there is no better estimate); after a timeout, do not immediately poll again—continue useful parent work or wait a comparable/longer interval before rechecking. Never launch duplicate copies of the same unfinished task merely to make it finish sooner.

## GitHub Actions budget

Treat GitHub-hosted CI as a scarce, billable resource.

- Batch related work and use one push per repair/implementation cycle by default.
- Run the locally available checks relevant to the requested change before using hosted CI. Do not run unrelated suites merely to be exhaustive.
- When CI fails, inspect the related failures together and make a consolidated fix. Do not use repeated push-and-see debugging.
- Do not create temporary/diagnostic workflows or commits whose purpose is only to obtain more CI logs.
- Do not proactively dispatch Full CI unless the user explicitly asks for it. Preserve required branch-protection, release, deployment, and security checks.
- When materially editing ordinary CI, avoid duplicate feature-branch `push` + `pull_request` verification unless required, and use `concurrency` / `cancel-in-progress: true` where appropriate. Do not alter deployment/release concurrency semantics without explicit instruction.

## Long-running Codex work

Use the repo-local `project-long-run` skill only for a substantial autonomous task with an active bounded objective in `docs/CODEX_LONG_RUN.md`, or when the user explicitly asks to establish such an objective.

- `Current bounded objective` is the completion contract. If it is `INACTIVE`, do not invent a long-running objective from TODOs, old branches, or historical notes.
- Read only the authoritative docs named by the active objective or required by the area being changed.
- Continue through implementation, relevant local verification, repair, final-diff review, and coherent commit until the objective's stopping condition is satisfied or a genuine blocker is reached.
- Load `docs/CODEX_CLOUD_PUBLICATION.md` only when publication from Codex Cloud is actually relevant. Do not spend task time repairing absent sandbox remotes/authentication.
- Follow-up CI/review repairs should normally update the same PR branch rather than create a replacement PR.

## ChatGPT -> Codex delegation

Only when preparing or processing a ChatGPT-to-Codex handoff, read `docs/CHATGPT_CODEX_HANDOFF.md`. Do not load that handoff contract for ordinary repository work.

## Design skills

Use the repo-local design skills only when their descriptions match the current task. Do not load design references for non-design work.
