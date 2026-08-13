# Template internals

This repository is intended to be used as a GitHub template for Codex Cloud projects.

It is self-contained and requires no per-Environment setup script.

Included:

- `AGENTS.md`: GitHub Actions cost-control policy, long-running Codex rules, and design routing.
- `.agents/skills/project-long-run`: autonomous bounded-objective execution through local validation, repair, push, and PR handoff.
- `docs/CODEX_LONG_RUN.md`: stable handoff point for the current bounded Codex objective; starts `INACTIVE` in a new repository.
- `.agents/skills/hallmark`: anti-generic/anti-AI-looking UI guidance.
- `.agents/skills/design-toolkit`: local reference catalog for design directions.
- `.agents/skills/apple-hig`: compact Apple-platform interface checklist.

## New repository operating setup

When a new repository is created from this template:

1. Keep `docs/CODEX_LONG_RUN.md` inactive until ChatGPT or the user defines a bounded, verifiable objective.
2. For substantial Codex work, activate that objective and launch Codex with the fixed prompt recorded in `docs/CODEX_LONG_RUN.md`.
3. Prefer local validation before push. Hosted CI should not duplicate the same checks on both feature-branch `push` and `pull_request` unless there is a concrete repository requirement.
4. Prefer PR-based hosted checks plus `workflow_dispatch`, and use `concurrency` / `cancel-in-progress: true` for ordinary CI where appropriate.
5. Codex should push once by default and create/update a draft PR when supported. CI/review repairs should normally update the same PR.
6. When ChatGPT first sets up substantial work for the new repository, add its `owner/name` to the user's active ChatGPT `Codex PR Watch` monitoring task. The repository cannot register that ChatGPT task by itself.
7. The watch should remain hourly unless the user changes it and should notify only on material branch/PR/CI/review changes, supplying a ready-to-paste Codex repair instruction or the next Codex instruction.
8. If the ChatGPT conversation associated with the monitoring task has been deleted and the task is therefore paused, resume/recreate the monitoring task before relying on notifications.

## Fixed Codex launch prompt

```text
docs/CODEX_LONG_RUN.md の Current bounded objective を最後まで実行してください。AGENTS.md と project-long-run skill に従ってください。
```

Example design prompts:

- `Linear系を参考にして、Hallmarkも使ってこの画面を作って。`
- `design-toolkitからこのプロダクトに合う方向性を3つ比較して。`
- `Appleプラットフォームの慣習も踏まえてこの画面をレビューして。`
