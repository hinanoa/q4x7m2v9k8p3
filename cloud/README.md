# Cloud setup

Codex Cloud Environment から共通リソースを読み込むためのbootstrapです。

## Setup script

Environment の Setup script に次の1行を設定します。

```bash
curl -fsSL https://raw.githubusercontent.com/hinanoa/q4x7m2v9k8p3/main/cloud/setup.sh | bash
```

GitHub token / Secret は不要です。

Setupが成功するとCloudコンテナに次が作られます。

```text
~/.agents/skills/
├── hallmark/
├── apple-hig/
└── design-toolkit/

~/.design-toolkit/
└── design-library/

~/.codex/AGENTS.md
└── GitHub Actions budget policy
```

デザイン資料はsetup時にローカルへキャッシュされるため、agent phaseで外部GitHubアクセスを必要としません。

## 動作確認

新しいCloudタスクで例えば次を依頼します。

```text
design-toolkitで利用可能なデザインを一覧にして。
```

または:

```text
design-toolkitのLinear系を使って実装して。Hallmarkも適用して。
```

## 更新

toolkit更新後に古い内容が残る場合は、Codex Cloud Environment のcacheをリセットして新しいタスクを開始します。
