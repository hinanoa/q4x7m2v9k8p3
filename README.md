# q4x7m2v9k8p3

Shared Codex bootstrap resources.

## Codex Cloud

Set this as the Environment setup script:

```bash
curl -fsSL https://raw.githubusercontent.com/hinanoa/q4x7m2v9k8p3/main/cloud/setup.sh | bash
```

No repository token is required.

The bootstrap installs the repository's user-level skills, cached design references, and global working guidance into the Cloud task environment.

See [`cloud/README.md`](cloud/README.md) for the short setup notes.

## Local

```bash
bash scripts/install.sh
```

Use a design reference locally:

```bash
bash scripts/use-design.sh --list
bash scripts/use-design.sh linear .
```

Upstream snapshots are pinned in [`versions.env`](versions.env).
