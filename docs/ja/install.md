# 導入ガイド

## 60秒で導入

```bash
curl -fsSL https://raw.githubusercontent.com/goonobu-dot/local-agent-workbench/main/scripts/install.sh | bash
cd "$HOME/AgentWorkbench/local-agent-workbench"
make first-run
```

`make first-run` は、環境チェック、デモワークフロー作成、テンプレート一覧表示をまとめて実行します。

## 試してから導入

ローカルに直接インストールする前に、クローンして安全に確認できます。

```bash
git clone https://github.com/goonobu-dot/local-agent-workbench.git
cd local-agent-workbench
./scripts/doctor.sh
make demo
```

## 必要なもの

- macOS
- `tmux`
- Codex CLI
- `git`
- `python3`

`tmux` がない場合:

```bash
brew install tmux
```

## 起動

```bash
cd "$HOME/AgentWorkbench/local-agent-workbench"
./scripts/launch_codex_tmux.sh
```

## アンインストール

```bash
cd "$HOME/AgentWorkbench/local-agent-workbench"
./scripts/uninstall.sh
```

アプリ本体や Idea フォルダも削除したい場合だけ、確認用の環境変数を付けます。

```bash
AGENT_WORKBENCH_CONFIRM_UNINSTALL=1 \
AGENT_WORKBENCH_REMOVE_APP=1 \
AGENT_WORKBENCH_REMOVE_IDEA=1 \
./scripts/uninstall.sh
```

## 公開前の安全確認

```bash
make test
./scripts/audit_public_safety.sh
```

このチェックは、公開リポジトリに入れるべきではない秘密情報やローカルパスの混入を避けるためのものです。
