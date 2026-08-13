---
name: project-long-run
description: Execute a substantial repository objective autonomously from inspection through local validation, repair, commit, push, and PR handoff while obeying repository-specific AGENTS.md rules.
---

# Project Long-Run Execution

Use this skill for substantial, multi-step work where the repository defines a bounded objective in `docs/CODEX_LONG_RUN.md`.

## Authority and scope

1. Read the repository `AGENTS.md` first.
2. Read `docs/CODEX_LONG_RUN.md` and the authoritative project/specification documents it names.
3. Repository-specific security, privacy, architecture, data-integrity, product-rule, platform, and CI rules always override this generic skill.
4. Do not invent an objective. If `Current bounded objective` is inactive or missing a verifiable stopping condition, stop and report that the objective must be activated.
5. Stay inside the active objective. Do not opportunistically add unrelated features or broad refactors.

## Autonomous execution loop

For an active objective:

1. Inspect the repository state, relevant implementation, tests, docs, and existing failures before editing.
2. Form an internal implementation plan and identify dependencies and risk boundaries.
3. Implement the complete objective rather than stopping after scaffolding or a partial happy path.
4. Run the locally available checks named by the objective and `AGENTS.md`.
5. Diagnose failures, fix root causes, and rerun the relevant local checks until they pass or a genuine blocker is reached.
6. Review the final diff for scope creep, debug artifacts, secrets, unsafe logging, temporary workarounds, and accidental architecture/spec changes.
7. Commit coherently and push once by default. Additional pushes are allowed only for a genuinely remote-only issue or an explicitly requested follow-up.
8. Create or update a draft pull request when the environment supports it. If PR creation is unavailable, ensure the remote branch is pushed and report the exact branch name.
9. For follow-up work caused by CI or review feedback, update the same PR branch instead of opening a replacement PR unless the existing PR is no longer the correct unit of work.

## Do not stop for routine decisions

Do not ask for approval for ordinary implementation choices that can be resolved from repository conventions, authoritative docs, tests, or the active objective. Prefer the least destructive compatible choice.

Stop only for a genuine blocker, such as:

- missing external credentials or inaccessible infrastructure required to verify the objective;
- mutually incompatible authoritative requirements;
- a destructive or irreversible operation not authorized by the objective;
- a required product/specification decision that cannot be inferred safely;
- an inactive or materially underspecified bounded objective.

When blocked, preserve completed work, run all still-possible validation, push a coherent branch if appropriate, and state the blocker precisely.

## GitHub Actions budget

Treat GitHub-hosted Actions as a scarce resource. Local validation is the default. Do not use repeated push-and-see debugging, temporary workflows, or Full CI unless explicitly authorized by `AGENTS.md` or the active objective.

When the same verification would run on both an ordinary feature-branch `push` and the subsequent `pull_request`, prefer PR-only hosted verification plus `workflow_dispatch` unless the repository has a concrete reason to validate branch pushes independently.

## Completion report

At completion, report:

- what changed;
- the local checks actually run and their results;
- any checks not run and why;
- branch / commit / PR state;
- any residual risk or genuine blocker.

Do not claim verification that was not executed.