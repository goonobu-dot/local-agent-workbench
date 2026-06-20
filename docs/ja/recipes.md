# レシピ

Local Agent Workbench の真似しやすい使い方です。まず小さく試して、出力を見てから自分の作業に合わせて調整してください。

## 1. 技術ネタを複数視点で調べる

新しいツール、ライブラリ、AIワークフローを見つけたときに使います。

おすすめの分担:

- Pane 1: 何の問題を解決するか
- Pane 2: 具体例を探す
- Pane 3: リスクや弱点を見る
- Pane 4: 似たプロジェクトを探す
- Pane 5: ローカルで試す方法を考える
- Pane 6: 今は無視してよい点を分ける
- Pane 7: OSSメンテナンスに役立つか見る
- Pane 8: 盛り上がりすぎていないか疑う
- Pane 9: 最終判断を書く

良い出力: 参考情報、リスク、次に試すことがまとまった短い判断メモ。

## 2. GitHub Issueをメンテナー向けメモにする

Issueが長い、曖昧、情報が散らかっているときに使います。

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123
./scripts/workflow_status.sh "$HOME/AgentWorkbench/Idea"
```

良い出力: 再現状況、怪しいコード箇所、修正案、テスト、返信案。

## 3. PRレビューを観点ごとに分ける

動作、テスト、安全性、互換性、ドキュメント、リリースノートを別々に見ます。

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/pull/123
```

良い出力: マージ判断、ブロッカー、軽微な提案、追加テスト。

## 4. リリース前チェックを分担する

タグを切る前に、変更履歴、互換性、スモークテスト、既知の問題を整理します。

```bash
./scripts/new_workflow.sh release-prep
```

良い出力: リリース可否、確認コマンド、リリースノート、フォローアップIssue。

## 5. 機能アイデアを比較する

作りたい案が複数あるときに、どれを先にやるか決めます。

```bash
./scripts/new_workflow.sh feature-discovery
```

良い出力: 採用する範囲、見送る案、テスト方針。

## 6. 結果をまとめる

paneがメモを書いたら、最後にまとめます。

```bash
./scripts/close_workflow.sh "$HOME/AgentWorkbench/Idea"
```

共有前に確認します。

```bash
./scripts/validate_workflow.sh "$HOME/AgentWorkbench/Idea"
```
