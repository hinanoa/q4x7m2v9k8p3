# my-design-toolkit

作品ごとにGitHubリポジトリを分けても、共通のデザインSkillとGitHub運用ルールを使い回すための個人用ツールキットです。

現在は **Codex Cloudで使うことを主用途**として構成しています。ローカルCodexでも同じインストーラを利用できます。

## できること

- **Hallmark** をユーザー共通Skillとしてインストール
- **Apple HIG Agent Skill** をユーザー共通Skillとしてインストール
- **design-toolkit Skill** を追加し、自然文からデザイン参照を選択・適用
- **awesome-design-md** をsetup時にローカルキャッシュし、agent実行中はネットなしで参照
- **GitHub Actions節約ルール** をCodexのグローバル指示としてインストール
- 取得元は `versions.env` のコミットSHAで固定し、再現性を維持

インストール後の主な状態:

```text
~/.agents/skills/
├── hallmark/
├── apple-hig/
└── design-toolkit/

~/.design-toolkit/
└── design-library/
    ├── apple/DESIGN.md
    ├── linear.app/DESIGN.md
    ├── stripe/DESIGN.md
    └── ...

~/.codex/AGENTS.md
└── my-design-toolkit 管理ブロック
```

---

# Codex Cloud

## 1. private repo読み取り用Tokenを作る

この `my-design-toolkit` はprivate repoなので、Codex CloudのSetup scriptが取得できるよう、GitHub fine-grained personal access tokenを用意します。

推奨権限:

- Repository access: `hinanoa/my-design-toolkit` のみ
- Repository permissions: **Contents: Read-only**

書き込み権限は不要です。

## 2. Codex Cloud EnvironmentにSecretを登録

EnvironmentのSecretsに次を追加します。

```text
DESIGN_TOOLKIT_TOKEN=<fine-grained token>
```

## 3. Setup scriptを登録

[`cloud/setup.sh`](cloud/setup.sh) の内容をCodex Cloud EnvironmentのSetup script欄に貼り付けます。

詳細手順は [`cloud/README.md`](cloud/README.md) にあります。

このsetupはprivateなtoolkit repoを取得したあと、以下をCloudコンテナへインストールします。

```text
Hallmark
Apple HIG
design-toolkit
awesome-design-md cache
GitHub Actions budget policy
```

デザイン集はsetupフェーズで取得して `$HOME/.design-toolkit/design-library` に保存するため、通常のagentフェーズでインターネットアクセスを有効にする必要はありません。

> 各作品repoにこの設定用の `AGENTS.md` やSkillをコピーする必要はありません。ただしCodex Cloud側では、使用するEnvironmentにこのSetup scriptを一度設定してください。

## Cloudでの使い方

例えばCodexへそのまま:

```text
my-design-toolkit の Linear 系を使ってこの画面をデザインして。
Hallmarkも適用して、AIっぽいUIを避けて。
```

または:

```text
デザインライブラリからこのプロダクトに合うものを選んで実装して。
```

Apple系UIなら:

```text
my-design-toolkit の Apple 系デザインを参考にして、Apple HIGも適用して。
```

`design-toolkit` Skillは、名前を指定された場合に対応する `DESIGN.md` を探して読みます。例えば `linear` は一意なら `linear.app` に解決できます。

既存のrepoに `DESIGN.md` がある場合は勝手に上書きしません。

### 利用可能デザインを確認

Codexに自然文で:

```text
my-design-toolkitで利用できるデザインを一覧にして。
```

またはシェルでは:

```bash
bash "$HOME/.agents/skills/design-toolkit/scripts/use-design.sh" --list
```

特定デザインのパス確認:

```bash
bash "$HOME/.agents/skills/design-toolkit/scripts/use-design.sh" --path linear
```

### Toolkitを更新した場合

Codex Cloud Environmentはコンテナをキャッシュするため、このrepoを更新したあと新しい内容を確実に利用したい場合はEnvironmentのcacheをリセットしてください。

---

# GitHub Actionsの消費を抑える共通ルール

[`global/AGENTS.md`](global/AGENTS.md) をCodex homeの `AGENTS.md` に管理ブロックとして組み込みます。

主なルール:

- 修正ごとにpushせず、1修正サイクル原則1push
- CI失敗は関連ログをまとめて解析してから修正
- format / lint / typecheck / test / build は可能な限りローカル優先
- `.github/workflows` に診断用・temporary workflowを作らない
- CIログ取得だけを目的としたcommit / pushをしない
- Full CIを能動的に実行するのは明示指示がある場合だけ
- 通常のCI workflowを新規作成・大きく編集するときは `concurrency` と `cancel-in-progress: true` を設定
- 不要な `push` triggerを増やさず、event / branch / path scopeを必要最小限にする
- branch protection、release、deployment、security上必要なチェックは勝手に弱めない

既存のグローバル `AGENTS.md` は丸ごと上書きせず、このtoolkit用の管理ブロックだけ差し込み・更新します。

`AGENTS.override.md` がCodex homeに存在する場合はそちらが優先されるため、インストーラが警告します。

---

# ローカルCodexで使う場合

このrepoをcloneして:

```bash
bash scripts/install.sh
```

これでCloudと同じユーザーSkill、デザインキャッシュ、グローバル指示がローカル環境にも入ります。

デザインを手動で現在のrepoへ適用する場合:

```bash
bash scripts/use-design.sh linear .
```

既存 `DESIGN.md` を意図的に置換するときだけ:

```bash
bash scripts/use-design.sh linear . --force
```

---

# バージョン更新

取得元と固定コミットは [`versions.env`](versions.env) にまとめています。

- Hallmark: `nutlope/hallmark`
- Apple HIG Agent Skills: `justinwetch/HIGAgentSkills`
- DESIGN.md library: `VoltAgent/awesome-design-md`

コミットSHAを更新したら `scripts/install.sh` を再実行します。Codex CloudではEnvironment cacheもリセットしてください。

## アンインストール

```bash
bash scripts/uninstall.sh
```

Hallmark / Apple HIG / design-toolkit / デザインキャッシュを削除し、Codex homeの `AGENTS.md` からはtoolkit管理ブロックだけを削除します。既存のユーザー指示は保持します。
