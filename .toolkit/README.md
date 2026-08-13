# Template internals

This repository is intended to be used as a GitHub template for Codex Cloud projects.

It is self-contained and requires no per-Environment setup script.

Included:

- `AGENTS.md`: GitHub Actions cost-control policy, long-running Codex rules, cross-repository ChatGPT→Codex delegation contract, and design routing.
- `.agents/skills/project-long-run`: autonomous bounded-objective execution through local validation, repair, push, and PR handoff.
- `docs/CODEX_LONG_RUN.md`: stable handoff point for the current bounded Codex objective; starts `INACTIVE` in a new repository.
- `.agents/skills/hallmark`: anti-generic/anti-AI-looking UI guidance.
- `.agents/skills/design-toolkit`: local reference catalog for design directions.
- `.agents/skills/apple-hig`: compact Apple-platform interface checklist.

## New repository operating setup

When a new repository is created from this template:

1. Keep `docs/CODEX_LONG_RUN.md` inactive until ChatGPT or the user defines a bounded, verifiable objective.
2. When ChatGPT judges that a task should be delegated to Codex, it should begin the user-facing response with the exact sentence `codexに投げるべきと判断しました。` and immediately provide complete ready-to-paste Codex prompt(s). Safe independent scopes should be split for concurrent submission.
3. Every normal Codex implementation prompt must explicitly require final self-review, coherent commit, one push by default, PR creation/update, and the PR URL in the final response. A task that remains only inside the Codex session is not considered handed off.
4. If Codex genuinely cannot create a PR, it should push the branch when possible and report the exact branch and blocker instead of claiming normal completion.
5. For substantial Codex work, activate the bounded objective and launch Codex with the fixed prompt recorded in `docs/CODEX_LONG_RUN.md` when that flow is appropriate.
6. Prefer local validation before push. Hosted CI should not duplicate the same checks on both feature-branch `push` and `pull_request` unless there is a concrete repository requirement.
7. Prefer PR-based hosted checks plus `workflow_dispatch`, and use `concurrency` / `cancel-in-progress: true` for ordinary CI where appropriate.
8. CI/review repairs should normally update the same PR rather than open a replacement PR.
9. After Codex creates a PR, ChatGPT should normally inspect the diff/check/review state, consolidate routine repairs on the same PR, and merge when appropriate and authorized instead of requiring the user to relay ordinary PR review steps.
10. The user's ChatGPT `Codex PR Watch` is expected to auto-discover accessible `hinanoa` repositories that contain both `docs/CODEX_LONG_RUN.md` and `.agents/skills/project-long-run/SKILL.md`; no per-repo watch-list edit should be required.
11. The watch should remain hourly unless the user changes it and should notify only on material branch/PR/CI/review changes, supplying a ready-to-paste Codex repair instruction or the next Codex instruction. A pushed Codex branch with no PR is an incomplete handoff and should trigger a PR-publication follow-up.
12. GitHub monitoring does not itself launch a new Codex Cloud task. Unless an actual Codex-launch tool is available and used, the user submits the next ready-to-paste Codex instruction when a new Codex execution is required.
13. The repository cannot create or resume the external ChatGPT monitoring task itself. If the task is paused or if its associated ChatGPT conversation has been deleted, resume/recreate the task before relying on notifications.

The ChatGPT→Codex delegation, GitHub publication, and PR-handoff rules are user-level rules and also apply to existing repositories that predate this template update.

## Fixed Codex launch prompt

```text
docs/CODEX_LONG_RUN.md の Current bounded objective を最後まで実行してください。AGENTS.md と project-long-run skill に従ってください。
```

Example design prompts:

- `Linear系を参考にして、Hallmarkも使ってこの画面を作って。`
- `design-toolkitからこのプロダクトに合う方向性を3つ比較して。`
- `Appleプラットフォームの慣習も踏まえてこの画面をレビューして。`
