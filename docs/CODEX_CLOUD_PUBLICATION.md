# Codex Cloud publication transport

This contract separates **task execution inside the Codex sandbox** from **publishing the finished task to GitHub**.

## Why this exists

A Codex Cloud task may have a repository checkout while its task shell does not expose a usable `origin`, GitHub credentials, `gh` authentication, or a callable PR-publication tool. That does not mean the implementation failed. It means GitHub publication belongs to the Codex product/UI boundary rather than to the sandbox shell.

Do not waste task time trying to repair that boundary from inside the sandbox.

## Required task behavior

For Codex Cloud implementation tasks:

1. Implement the bounded objective completely.
2. Run all reasonably available local validation.
3. Self-review the final diff.
4. Create a coherent local commit on a dedicated task branch/worktree.
5. Determine publication capability once, without repeated trial-and-error.
6. If a native Codex PR/publish action is callable from the task environment, use it.
7. If no callable publication action exists, stop terminal publication attempts and return a `PUBLICATION_PENDING_UI` handoff.

## Capability probe

Do not assume shell GitHub access merely because the task was created from a GitHub repository.

At most one lightweight publication capability check is appropriate. For example, inspect `git remote -v` and the tools actually exposed to the task. Do not repeatedly run `git push`, `gh auth`, remote rewrites, proxy workarounds, token experiments, or credential setup when the environment clearly does not provide GitHub publication credentials.

In particular:

- missing `origin` is a transport boundary, not an implementation bug;
- `gh auth status` showing no login is not a reason to spend time authenticating inside the sandbox;
- network/proxy 403 failures should not trigger repeated push attempts;
- never invent a PR URL.

## `PUBLICATION_PENDING_UI` handoff

When the code is complete but publication is not callable from the sandbox, the final Codex response must include:

- status: `PUBLICATION_PENDING_UI`;
- repository;
- intended base branch;
- task branch/worktree name;
- local commit SHA;
- concise implementation summary;
- exact local verification results;
- whether Blender/device/external runtime validation is still pending;
- proposed PR title;
- proposed PR body/summary;
- exact publication blocker observed;
- a direct instruction to use the Codex task's **Create PR / Push PR / Publish** control (wording may vary by client) rather than shell `git push`.

This state means **implementation complete, GitHub handoff incomplete**.

## After the PR becomes GitHub-visible

Once the PR exists on GitHub, ChatGPT should normally take over routine continuation:

- inspect diff/checks/review threads;
- fix small or medium defects directly on the same PR when efficient and authorized;
- otherwise provide one consolidated Codex follow-up prompt for the same PR;
- merge when appropriate and authorized;
- decide whether the next bounded objective can begin.

The user should not have to manually relay ordinary PR review/fix cycles after the PR is visible.

## Non-cloud environments

For local Codex/CLI/app worktrees that genuinely have an authenticated remote, the normal one-push handoff remains valid: self-review -> commit -> push -> create/update PR -> return PR URL.

Do not force the Cloud fallback onto an environment that can publish normally.
