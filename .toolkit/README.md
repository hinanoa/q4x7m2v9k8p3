# Template internals

This repository is intended to be used as a GitHub template for Codex projects. It is self-contained and requires no per-Environment setup script.

The agent guidance is intentionally split so ordinary tasks do not load workflow material they do not need:

- `AGENTS.md`: compact always-on task routing, hard boundaries, CI budget, and pointers to on-demand guidance.
- `.agents/skills/project-long-run`: minimal router/execution contract for an **active bounded** long-running objective.
- `docs/CODEX_LONG_RUN.md`: only the current bounded objective and its stopping condition; starts `INACTIVE`.
- `docs/CHATGPT_CODEX_HANDOFF.md`: loaded only for ChatGPT -> Codex delegation/publication continuation.
- `docs/CODEX_CLOUD_PUBLICATION.md`: loaded only when Codex Cloud publication is actually relevant.
- `.agents/skills/hallmark`, `design-toolkit`, `apple-hig`: loaded only when their narrow design triggers match the task.

## Operating rules

1. Do not turn `AGENTS.md` into a repository manual. Put detailed domain guidance in authoritative docs and route to it only when the task touches that domain.
2. Do not require a fixed stack of docs before every edit. The active task/objective should name the authoritative docs it actually needs.
3. Keep skill descriptions short and specific enough to prevent accidental activation. A skill root should route to deeper references rather than duplicate them.
4. A long-running task must define what completion means. Continue through required execution/inspection/repair until that stopping condition is met; do not use an unbounded "never stop" instruction.
5. Prefer local, task-relevant verification. Hosted CI remains a scarce resource; one push per completed repair cycle is the default.
6. If a bounded objective is `INACTIVE`, do not invent work from historical TODOs or branches.
7. When ChatGPT decides to delegate to Codex, follow `docs/CHATGPT_CODEX_HANDOFF.md`; otherwise do not load that contract.
8. CI/review repairs normally update the same PR branch.
9. Repositories created from this template can still be discovered by the user's GitHub/Codex monitoring workflow through `docs/CODEX_LONG_RUN.md` and `.agents/skills/project-long-run/SKILL.md`.

## Fixed Codex launch prompt

```text
docs/CODEX_LONG_RUN.md の Current bounded objective を最後まで実行してください。AGENTS.md と project-long-run skill に従ってください。
```

Example design prompts:

- `Linear系を参考にして、Hallmarkも使ってこの画面を作って。`
- `design-toolkitからこのプロダクトに合う方向性を3つ比較して。`
- `Appleプラットフォームの慣習も踏まえてこの画面をレビューして。`
