# 公開AIワークフロー・ポートフォリオ

このページは、`goonobu-dot` が公開しているAIワークフロー関連プロジェクトをまとめたものです。

OpenAI Codex for Open Source への応募で主役にしているのは
[`local-agent-workbench`](https://github.com/goonobu-dot/local-agent-workbench)
です。その他のリポジトリは、主役を置き換えるものではなく、公開活動の広がりを示す補助資料です。

## 主対象: OSSメンテナンス支援

### local-agent-workbench

リポジトリ:
https://github.com/goonobu-dot/local-agent-workbench

Codex CLIを最大9つ、1つのtmux画面に並べて使うローカル作業台です。
Issue整理、PRレビュー、リリース準備、セキュリティ確認、ドキュメント改善、機能調査を役割別に分担できます。

OpenAI応募での強み:

- OSSメンテナーの継続作業に直接対応している
- AIの出力をMarkdownとして残し、人間が確認できる
- 自動マージではなく、人間の最終判断を前提にしている
- 初心者向け資料、利用例、CI、安全監査、レビュアー向け手順がある

## 関連するメンテナー支援ツール

### codex-maintainer-kit

リポジトリ:
https://github.com/goonobu-dot/codex-maintainer-kit

リポジトリの状態を調べ、メンテナーブリーフ、Codex向けタスク、Issue下書きを作るCLIです。

### codex-maintainer-action

リポジトリ:
https://github.com/goonobu-dot/codex-maintainer-action

`codex-maintainer-kit` の考え方をGitHub Actionsから実行できるようにするプロジェクトです。

## 関連するAI作業台

### claude-code-workbench

リポジトリ:
https://github.com/goonobu-dot/claude-code-workbench

Claude Code CLIを複数画面で動かし、調査、設計、レビューを分担するローカル作業台です。

## 関連する業務自動化プロジェクト

### ai-automation-starter-kit

リポジトリ:
https://github.com/goonobu-dot/ai-automation-starter-kit

GitHub上の便利なOSSを、業務自動化に使える候補として検討するためのスターターキットです。
役に立つか、安全に試せるか、ライセンスに問題がないか、誰が確認するか、効果をどう測るかまで整理します。

## 全体として大事にしていること

これらの公開プロジェクトに共通しているのは、AIをただ動かすことではありません。

1. ぼんやりしたAI活用を、具体的な作業手順にする
2. 出力をMarkdown、Issue、レポート、チェックリストとして残す
3. 初心者にも目的が分かる資料を用意する
4. 人間のレビューなしに重要な変更を進めない
5. 安全確認、実行例、再現できるコマンドを公開する

つまり、このポートフォリオは「AIで何か作った」という一覧ではなく、AIエージェントを安全に、分かりやすく、再利用しやすい形で使うための公開活動です。
