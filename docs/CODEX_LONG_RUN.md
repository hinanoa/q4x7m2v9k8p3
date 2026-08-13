# Codex long-run handoff

This file is the stable handoff point for substantial autonomous Codex work.

## Fixed launch instruction

For normal Codex Cloud delegation, use:

```text
docs/CODEX_LONG_RUN.md の Current bounded objective を最後まで実行してください。AGENTS.md と project-long-run skill に従ってください。
```

The repository-specific `AGENTS.md` rules always take precedence over this generic handoff.

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
- PR handoff: push a coherent branch once by default and create/update a draft PR when supported.
- Stopping condition: objective evidence that determines completion.
- Blockers: conditions that justify stopping for user input.

## Follow-up repair contract

If a PR created from this objective later fails CI or receives actionable review feedback, the follow-up objective should normally target the **same PR branch**. Diagnose all related failures together, repair locally, rerun relevant checks, then push a consolidated update rather than opening a replacement PR or repeatedly pushing speculative fixes.

## Parallel execution

Multiple Codex tasks may run in parallel only when their write scopes are independent or intentionally coordinated. Do not assign simultaneous tasks that modify the same architectural foundation unless an explicit integration plan exists.

## ChatGPT PR monitoring handoff

Repos created from the shared hinanoa template are intended to participate in the user's ChatGPT `Codex PR Watch` monitoring workflow. The repository itself cannot register a ChatGPT Scheduled/Monitoring task.

When ChatGPT first sets up or begins substantial work on a newly created repository from this template, it should:

1. verify that the repository has GitHub access;
2. add the repository's `owner/name` to the user's existing `Codex PR Watch` monitoring task, if that task is active;
3. keep the monitoring task at hourly frequency unless the user changes it;
4. monitor new/updated Codex or agent branches, PR diffs, CI/check state, and review threads;
5. notify only on material state changes;
6. when repair is needed, provide a ready-to-paste Codex follow-up instruction for the same PR;
7. when a PR passes, provide the next Codex instruction or identify the product decision needed before another bounded objective can be activated.

If the monitoring task is paused or unavailable, tell the user rather than assuming the repository is being watched.