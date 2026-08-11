# my-design-toolkit

作品ごとにリポジトリを分けても、共通のデザインSkillを使い回すための個人用ツールキットです。

## できること

- **Hallmark** をユーザー共通Skillとしてインストール
- **Apple HIG Agent Skill** をユーザー共通Skillとしてインストール
- **awesome-design-md** から好きなデザインだけを各作品repoの `DESIGN.md` として適用
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
```

Codexはユーザー共通Skillを `$HOME/.agents/skills` から読み込むため、別の作品repoに移動してもこの2つを利用できます。

Codex上では `/skills` で確認できます。Skillがすぐに出ない場合はCodexを再起動してください。

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
├── AGENTS.md      # その作品固有の開発・エージェント指示
├── DESIGN.md      # その作品固有のビジュアル方針
└── src/
```

Hallmark / Apple HIG はグローバル、`DESIGN.md` は作品ごと、という分担です。

## バージョン更新

取得元と固定コミットは [`versions.env`](versions.env) にまとめています。

アップデートするときはコミットSHAを変更してから、再度:

```bash
bash scripts/install.sh
```

を実行します。

## アンインストール

```bash
bash scripts/uninstall.sh
```

## Sources

- Hallmark: `nutlope/hallmark`
- Apple HIG Agent Skills: `justinwetch/HIGAgentSkills`
- DESIGN.md library: `VoltAgent/awesome-design-md`

このrepo自体には第三者プロジェクトの全ファイルを複製せず、指定コミットから必要なSkill/デザインだけを取得する構成にしています。
