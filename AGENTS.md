# Repository-wide agent instructions

## GitHub Actions budget policy

Treat GitHub-hosted CI as a scarce, billable resource. Minimize GitHub Actions minutes by default.

- Do not push after each edit. Batch related changes locally and push only when the repair or implementation cycle is ready for remote validation.
- Use at most one push per repair cycle by default. Make an additional push only when remote-only validation is genuinely necessary and cannot be reproduced locally.
- When CI fails, inspect and group all relevant failures first, identify likely shared root causes, then make a consolidated fix. Do not use repeated push-and-see debugging.
- Before pushing, run every relevant check that is reasonably available locally, such as formatting, linting, type checking, targeted tests, and builds. Fix local failures before using GitHub-hosted CI.
- Do not add diagnostic, temporary, experimental, or throwaway workflows under `.github/workflows/` merely to investigate a problem.
- Do not create commits or pushes whose only purpose is to obtain more CI logs. Use existing run/job logs and local reproduction instead.
- Do not proactively dispatch or otherwise invoke Full CI unless the user explicitly asks for Full CI. If an existing workflow automatically runs Full CI on push, reduce pushes rather than using CI as an iterative debugger.
- When creating or materially editing ordinary CI workflows, configure `concurrency` and `cancel-in-progress: true` so superseded runs are cancelled. Do not change deployment/release concurrency semantics without explicit instruction.
- Do not introduce unnecessary `push` triggers. Keep workflow event scope as narrow as repository requirements allow, using appropriate branch/path filters or pull-request events where applicable.
- If the same ordinary verification would run for both a feature-branch `push` and the subsequent `pull_request`, prefer PR-only hosted verification plus `workflow_dispatch` unless the repository has a concrete requirement for independent push validation.
- Preserve required branch protection, release, deployment, and security checks. Cost reduction must not silently weaken required safeguards.

### Preferred repair loop

1. Inspect the repository, current diff, workflow definitions, and all available failing CI evidence.
2. Reproduce failures locally where possible.
3. Make the complete related fix locally.
4. Run relevant local format/lint/typecheck/test/build checks.
5. Review the final diff and confirm no temporary workflow/debug artifacts were added.
6. Commit coherently and push once.
7. Only if remote CI reveals a genuinely remote-only issue, repeat the loop and make the minimum additional push.

## Long-running Codex work

For substantial multi-step work, use the repo-local `project-long-run` skill and the active bounded objective in `docs/CODEX_LONG_RUN.md`.

- Do not invent work when the bounded objective is `INACTIVE`.
- Read repository-specific product/spec/security/architecture rules before implementation; they override the generic long-run skill.
- Continue through implementation, local verification, repair, final diff review, coherent commit, one push, and GitHub PR handoff by default.
- Unless the user explicitly requests a no-PR workflow or the repository genuinely cannot support pull requests, Codex completion requires: commit the completed work, push the task branch, create or update a PR to the intended base branch, and return the PR URL in the final response.
- Do not report a delegated implementation task as complete while its finished work exists only inside the Codex task/session and is not GitHub-visible. If PR creation is genuinely unavailable, push the branch when possible and report the exact branch plus blocker instead of pretending the handoff is complete.
- If CI or review feedback requires a follow-up, normally repair the same PR branch instead of creating a replacement PR.
- Do not stop for routine implementation decisions that can be resolved from the repository, tests, authoritative docs, or the active objective.
- Stop only for a genuine blocker, destructive/irreversible operation not authorized by the objective, or a product/spec decision that cannot safely be inferred.

Repos created from this template are intended to be automatically discoverable by the user's hourly ChatGPT `Codex PR Watch` monitoring task through the shared long-run markers in this repository. Repository files cannot create or resume that external ChatGPT task themselves; follow the handoff notes in `docs/CODEX_LONG_RUN.md`.

## Cross-repository ChatGPT -> Codex delegation contract

This is a user-level operating rule and is not limited to one repository. Apply it to every existing repository the user works on and to every repository created from this template.

- When ChatGPT judges that implementation should be delegated to Codex instead of being performed directly in the current chat, the user-facing response must begin with the exact sentence: `codexに投げるべきと判断しました。`
- Immediately after that sentence, provide the complete ready-to-paste Codex instruction. Do not require the user to reconstruct scope, acceptance criteria, file paths, verification steps, or constraints from surrounding conversation.
- Every normal implementation prompt delegated to Codex must include the GitHub handoff explicitly: self-review the final diff, commit coherently, push the dedicated branch, create/update the PR, and return the PR URL. If the environment cannot create a PR, it must say so explicitly and return the pushed branch and exact blocker.
- When independent write scopes make safe parallelism possible, split the work into clearly named tasks and state that they may be submitted to Codex concurrently.
- Preserve repository-specific constraints in every generated Codex prompt, including authoritative docs, allowed/out-of-scope paths, local verification, GitHub Actions budget rules, and the expected PR handoff.
- If ChatGPT judges that direct work is more efficient, do not emit the delegation sentence; continue the work directly.
- After Codex creates a PR, ChatGPT should normally inspect the diff, CI/check state, and review threads itself; make or specify consolidated repairs on the same PR; and merge when appropriate and authorized, rather than making the user manually relay routine review/fix steps.
- The PR monitor can only act on GitHub-visible branches/PRs. A Codex task marked complete without a push/PR is not considered handed off and may be invisible to monitoring.
- A successful Codex PR is not automatically the end of the workflow. ChatGPT should decide whether the next bounded objective can begin, whether a quality/product decision is required, or whether another repair cycle is needed.
- Current ChatGPT tooling may monitor GitHub and prepare the next Codex prompt, but it must not imply that a fresh Codex Cloud task has been launched automatically unless an actual Codex task-launch tool is available and used. Until then, the user submits the next ready-to-paste Codex instruction when a new Codex task is required.

## Design resources

Repo-local Codex skills live under `.agents/skills/` and require no Cloud Environment setup.

- For UI work that should feel less generic, less template-like, or less AI-generated, use the `hallmark` skill.
- When the user names a visual reference such as Linear, Apple, Figma, Stripe, Notion, Airbnb, Vercel, etc., use the `design-toolkit` skill.
- For Apple-platform interface work, also use `apple-hig`.
- If the user asks you to choose a design direction, use `design-toolkit` to compare a small number of suitable references before implementing.
- Use named brands as visual references only. Do not copy logos, trademarks, proprietary assets, distinctive branded illustrations, or exact page compositions.
