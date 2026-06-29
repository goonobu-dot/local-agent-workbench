# Local Agent Workbench 日本語ガイド

Local Agent Workbench は、Codex CLI を最大9画面まで1つの tmux ウィンドウに並べて、同じ作業フォルダに向けて動かすためのローカル作業台です。

OSS の Issue 調査、PRレビュー、リリース準備、機能アイデア出しを、1つのチャットではなく複数の視点で同時に進めたい人向けです。

## まず読むもの

- [docs/BEGINNER_GUIDE.ja.md](docs/BEGINNER_GUIDE.ja.md): 中学生でも分かるやさしい解説
- [docs/START_HERE.ja.md](docs/START_HERE.ja.md): 最初の3分で全体像をつかむ入口
- [docs/USE_CASES.ja.md](docs/USE_CASES.ja.md): Issue整理、PRレビュー、リリース準備などの具体例
- [docs/ja/recipes.md](docs/ja/recipes.md): 真似しやすい使い方レシピ
- [docs/ja/promotion-kit.md](docs/ja/promotion-kit.md): XやGitHubで紹介するための文例
- [docs/ja/install.md](docs/ja/install.md): 60秒で導入、試してから導入、アンインストール
- [docs/ja/quickstart.md](docs/ja/quickstart.md): 最初のワークフロー
- [docs/ja/use-cases.md](docs/ja/use-cases.md): 何に使えるか
- [docs/ja/faq.md](docs/ja/faq.md): ローカルMac、GitHub公開、APIキー、個人情報の不安
- [docs/ja/share.md](docs/ja/share.md): X投稿例、GitHub紹介文、プロフィール文
- [docs/ja/openai-credit-note.md](docs/ja/openai-credit-note.md): OpenAIクレジット応募で説明しやすい価値
- [docs/ja/public-ai-workflow-portfolio.md](docs/ja/public-ai-workflow-portfolio.md): 関連公開プロジェクトと応募補助資料

## 最短導入

```bash
curl -fsSL https://raw.githubusercontent.com/goonobu-dot/local-agent-workbench/main/scripts/install.sh | bash
cd "$HOME/AgentWorkbench/local-agent-workbench"
make first-run
```

インストールせずに確認したい場合:

```bash
git clone https://github.com/goonobu-dot/local-agent-workbench.git
cd local-agent-workbench
./scripts/doctor.sh
make demo
```

## これは何がうれしいのか

- 9つの Codex CLI セッションを同じフォルダに向けられる
- 役割別プロンプトで、再現、コード経路、テスト、安全性、ドキュメントを分担できる
- 出力が Markdown として残るので、あとから GitHub Issue、PR、リリースノートに転用しやすい
- 公開用のサンプル、導入チェック、セーフティ監査が同梱されている

## 安全面の考え方

このリポジトリを GitHub で見る人は、あなたのローカルMacや非公開フォルダを見られません。公開されるのは、このリポジトリに push したファイルだけです。

ワークフロー共有前には `./scripts/validate_workflow.sh` と `./scripts/export_workflow.sh` が、ローカル絶対パスや秘密情報らしき文字列を検査します。

## 英語版

English README: [README.md](README.md)
