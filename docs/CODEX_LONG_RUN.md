# Codex long-run handoff

This file is the stable handoff point for substantial autonomous Codex work.

## Fixed launch instruction

For normal Codex Cloud delegation, use:

```text
docs/CODEX_LONG_RUN.md の Current bounded objective を最後まで実行してください。AGENTS.md と project-long-run skill に従ってください。
```

The repository-specific `AGENTS.md` rules always take precedence over this generic handoff.

## Cross-repository ChatGPT delegation contract

The following rule applies to all of the user's repositories, not only repositories created from this template.

When ChatGPT decides that a task should be delegated to Codex, the user-facing response must begin with the exact sentence:

```text
codexに投げるべきと判断しました。
```

That sentence must be followed immediately by a complete ready-to-paste Codex instruction. The instruction should contain the relevant repository, authoritative docs, goal, scope, out-of-scope boundaries, required implementation, local verification, GitHub Actions budget constraints, stopping condition, and PR handoff. When safe parallel work exists, ChatGPT should split the work into independent prompts that may be launched concurrently.

For normal implementation work, the Codex prompt must explicitly require the complete GitHub publication handoff before the task is considered finished:

1. self-review the final diff;
2. commit the completed work coherently;
3. push the dedicated task branch;
4. create or update the intended pull request;
5. return the PR URL in the final Codex response.

If the environment genuinely cannot create a PR, Codex should push the branch when possible and report the exact branch and blocker. A task whose final work exists only inside a Codex session is not considered handed off or monitorable.

When direct work by ChatGPT is more efficient, ChatGPT should proceed directly instead of emitting the delegation sentence.

After Codex creates a PR, ChatGPT should normally handle routine PR review and continuation itself: inspect the diff/checks/review state, consolidate repairs on the same PR, and merge when appropriate and authorized. The user should not be used as a manual relay for ordinary PR inspection and repair steps.

The GitHub PR monitor only sees GitHub-visible state. It can detect branches/PRs, review them, and prepare the next ready-to-paste Codex instruction, but it does not itself prove that a fresh Codex Cloud task was launched. Unless a real Codex task-launch tool is available and used, the user submits the next Codex instruction when a new Codex execution is required.

## Current bounded objective

**INACTIVE**

Do not start substantial autonomous implementation from this file while this section is inactive.

Before activating it, replace `INACTIVE` with one bounded objective that contains all of the following:

- Goal: what outcome must exist when the task is complete.
- Scope: directories/components/features that may be changed.
- Out of scope: explicit boundaries that must not be crossed.
- Authority: project/specification documents that control behavior.
- Required implementation: concrete deliverables, including migration/schema/docs/tests when relevant.
- Local verification: exact or discoverable formatter/lint/typecheck/test/build commands that must be run locally where possible.
- PR handoff: self-review, commit, push the coherent task branch once by default, create/update the intended PR, and return its URL. If PR creation is unavailable, report the pushed branch and blocker explicitly.
- Stopping condition: objective evidence that determines completion.
- Blockers: conditions that justify stopping for user input.

## Follow-up repair contract

If a PR created from this objective later fails CI or receives actionable review feedback, the follow-up objective should normally target the **same PR branch**. Diagnose all related failures together, repair locally, rerun relevant checks, then push a consolidated update rather than opening a replacement PR or repeatedly pushing speculative fixes.

## Parallel execution

Multiple Codex tasks may run in parallel only when their write scopes are independent or intentionally coordinated. Do not assign simultaneous tasks that modify the same architectural foundation unless an explicit integration plan exists.

## ChatGPT PR monitoring handoff

Repos created from the shared hinanoa template are intended to participate in the user's ChatGPT `Codex PR Watch` monitoring workflow. The repository itself cannot register or resume a ChatGPT Scheduled/Monitoring task.

The watch is expected to run hourly and automatically discover accessible `hinanoa` repositories that contain both of these long-run markers:

- `docs/CODEX_LONG_RUN.md`
- `.agents/skills/project-long-run/SKILL.md`

For discovered repositories, the watch should:

1. monitor new/updated Codex or agent branches, PR diffs, CI/check state, and review threads;
2. notify only on material state changes;
3. when repair is needed, provide a ready-to-paste Codex follow-up instruction for the same PR;
4. when a PR passes, provide the next Codex instruction or identify the product decision needed before another bounded objective can be activated;
5. treat a pushed Codex branch with no PR as an incomplete publication handoff and provide the exact PR-creation follow-up rather than assuming the task is complete.

No per-repository watch-list edit should normally be required for a repository created from this template. If the monitoring task is paused or unavailable, tell the user rather than assuming the repository is being watched.
