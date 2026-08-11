# Codex Cloud setup

`my-design-toolkit` を Codex Cloud の各タスクで利用するためのセットアップです。

## 1. GitHub token を用意する

このrepoはprivateなので、Codex Cloudのsetup scriptから読むためのGitHub fine-grained personal access tokenを用意します。

推奨スコープ:

- Repository access: `hinanoa/my-design-toolkit` のみ
- Repository permissions: **Contents: Read-only**

書き込み権限は不要です。

## 2. Codex Cloud Environment にSecretを登録

CodexのEnvironment設定で次のSecretを追加します。

```text
DESIGN_TOOLKIT_TOKEN=<fine-grained token>
```

Secretはsetup時のprivate repo取得にだけ使います。

## 3. Setup scriptを設定

Codex Cloud EnvironmentのSetup script欄に [`setup.sh`](setup.sh) の内容を貼り付けます。

通常は追加の環境変数は不要です。必要なら以下を設定できます。

```text
DESIGN_TOOLKIT_REPO=hinanoa/my-design-toolkit
DESIGN_TOOLKIT_REF=main
```

Setupが成功すると、Cloudコンテナに次が作られます。

```text
~/.agents/skills/
├── hallmark/
├── apple-hig/
└── design-toolkit/

~/.design-toolkit/
└── design-library/
    ├── apple/DESIGN.md
    ├── linear.app/DESIGN.md
    └── ...

~/.codex/AGENTS.md
└── GitHub Actions budget policy
```

デザイン集はsetup時にキャッシュされるため、Codexのagent phaseでGitHubへアクセスしなくても参照できます。

## 4. 動作確認

新しいCloudタスクで例えば次のように依頼します。

```text
my-design-toolkit の Linear 系を使ってこの画面をデザインして。
Hallmarkも適用して、AIっぽいUIを避けて。
```

または明示的に確認する場合:

```text
利用可能なdesign-toolkitのデザインを一覧にして。
```

## 更新時

Cloud Environmentはコンテナをキャッシュするため、`my-design-toolkit` を更新したあと新しい内容を確実に取り込みたい場合はEnvironmentのcacheをリセットしてください。

`DESIGN_TOOLKIT_REF` を特定commit SHAに固定すれば、Cloud環境を完全に再現可能な状態にもできます。
