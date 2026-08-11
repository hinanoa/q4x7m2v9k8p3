# my-design-toolkit

作品ごとにリポジトリを分けても、共通のデザインSkillと開発ルールを使い回すための個人用ツールキットです。

## できること

- **Hallmark** をユーザー共通Skillとしてインストール
- **Apple HIG Agent Skill** をユーザー共通Skillとしてインストール
- **awesome-design-md** から好きなデザインだけを各作品repoの `DESIGN.md` として適用
- **GitHub Actions節約ルール** をCodexの全repo共通指示としてインストール
- 取得元は `versions.env` のコミットSHAで固定し、再現性を維持

## セットアップ

このrepoをPCにcloneしたら、次を実行します。

```bash
bash scripts/install.sh
```

インストール先は以下です。

```text
~/.agents/skills/
├── hallmark/
└── apple-hig/

~/.codex/AGENTS.md
└── my-design-toolkit 管理ブロック
```

`CODEX_HOME` を設定している場合、グローバル指示は `$CODEX_HOME/AGENTS.md` に入ります。

Codexはユーザー共通Skillを `$HOME/.agents/skills` から読み込み、グローバルな作業指示をCodex homeの `AGENTS.md` から読み込みます。そのため、別の作品repoに移動しても共通設定を利用できます。

インストール後はCodexを再起動してください。Skillは `/skills` で確認できます。

## GitHub Actions の消費を抑える共通ルール

[`global/AGENTS.md`](global/AGENTS.md) を `~/.codex/AGENTS.md` に管理ブロックとして組み込みます。

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

既存の `~/.codex/AGENTS.md` は上書きせず、このtoolkit用の管理ブロックだけ差し込み・更新します。

> `~/.codex/AGENTS.override.md` が存在する場合はCodex側でそちらがグローバル指示として優先されるため、インストーラが警告します。

### 有効化を確認する

任意の作品repoで新しいCodexセッションを開始して、例えば次を実行します。

```bash
codex --ask-for-approval never "Summarize the current instructions."
```

GitHub Actions budget policyがグローバル指示として出てくれば有効です。

## DESIGN.md を作品に適用する

利用可能なデザイン一覧を表示:

```bash
bash scripts/use-design.sh --list
```

例: Apple系デザインを作品repoへ適用:

```bash
bash scripts/use-design.sh apple ~/GitHub/my-app
```

例: Linear系デザイン:

```bash
bash scripts/use-design.sh linear.app ~/GitHub/my-app
```

対象repoにすでに `DESIGN.md` がある場合は、誤上書きを避けるため停止します。意図的に置き換える場合だけ `--force` を付けます。

```bash
bash scripts/use-design.sh apple ~/GitHub/my-app --force
```

### 各作品repoのおすすめ構成

```text
my-app/
├── AGENTS.md      # その作品にだけ必要な追加・上書き指示がある場合のみ
├── DESIGN.md      # その作品固有のビジュアル方針
└── src/
```

Hallmark / Apple HIG とGitHub Actions節約ルールはグローバル、`DESIGN.md` は作品ごと、という分担です。

## バージョン更新

取得元と固定コミットは [`versions.env`](versions.env) にまとめています。

アップデートするときはコミットSHAを変更してから、再度:

```bash
bash scripts/install.sh
```

を実行します。

`global/AGENTS.md` を変更した場合も、同じコマンドを再実行すれば管理ブロックが更新されます。

## アンインストール

```bash
bash scripts/uninstall.sh
```

Hallmark / Apple HIGを削除し、`~/.codex/AGENTS.md` からはtoolkit管理ブロックだけを削除します。既存のユーザー指示は保持します。

## Sources

- Hallmark: `nutlope/hallmark`
- Apple HIG Agent Skills: `justinwetch/HIGAgentSkills`
- DESIGN.md library: `VoltAgent/awesome-design-md`

このrepo自体には第三者プロジェクトの全ファイルを複製せず、指定コミットから必要なSkill/デザインだけを取得する構成にしています。
