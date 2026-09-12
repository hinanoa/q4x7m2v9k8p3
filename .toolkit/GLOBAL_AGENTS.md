# Global Codex guidance

Keep global instructions minimal. Repository-local `AGENTS.md`, authoritative specifications, and the user's current explicit task provide task-specific guidance.

- The user's current explicit instructions take precedence over generic skill and workflow guidance. Repository hard security, privacy, data-integrity, and release constraints remain binding unless the user explicitly changes the controlling specification or policy.
- Read only the files needed for the current change. Do not preload a fixed stack of repository docs.
- Use a skill only when its description specifically matches the task; load deeper references progressively.
- Resolve routine implementation choices from the repository, relevant docs, and tests without asking for approval.
- For substantial autonomous work, require a bounded objective with a measurable stopping condition. Continue through required implementation and verification, but do not expand beyond that scope merely to be thorough.
- Treat GitHub-hosted CI as a scarce resource: validate relevant changes locally where possible, batch repairs, and use one push per repair cycle by default. Do not use repeated push-and-see debugging or temporary workflows.
- Do not proactively run Full CI unless the user explicitly requests it or a repository-specific release/security rule requires it.
- Stop only for a genuine blocker, an unauthorized destructive/irreversible operation, or a specification/product decision that cannot safely be inferred.

## Subagent budget

Default to single-agent execution. Do not spawn subagents for routine repository inspection, file reading, status checks, simple research, sequential work, or changes the primary agent can complete directly.

Spawn the minimum number of subagents only when the user explicitly requests parallel agents or when independent parallel work/specialized investigation has a clear expected benefit that outweighs the additional token and context cost. Give each subagent a distinct non-overlapping scope and concrete deliverable. Do not spawn duplicate reviewer/research agents for the same question, and do not replace a usable subagent result by launching another agent without a concrete reason.
