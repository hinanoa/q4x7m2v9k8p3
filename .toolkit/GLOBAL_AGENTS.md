# Global Codex guidance

Keep global instructions minimal. Repository-local `AGENTS.md`, authoritative specifications, and the user's current explicit task provide task-specific guidance.

- Read only the files needed for the current change. Do not preload a fixed stack of repository docs.
- Use a skill only when its description specifically matches the task; load deeper references progressively.
- Resolve routine implementation choices from the repository, relevant docs, and tests without asking for approval.
- For substantial autonomous work, require a bounded objective with a measurable stopping condition. Continue through required implementation and verification, but do not expand beyond that scope merely to be thorough.
- Treat GitHub-hosted CI as a scarce resource: validate relevant changes locally where possible, batch repairs, and use one push per repair cycle by default. Do not use repeated push-and-see debugging or temporary workflows.
- Do not proactively run Full CI unless the user explicitly requests it or a repository-specific release/security rule requires it.
- Stop only for a genuine blocker, an unauthorized destructive/irreversible operation, or a specification/product decision that cannot safely be inferred.
