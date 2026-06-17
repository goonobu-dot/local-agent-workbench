# Workflows

These are practical ways to use Local Agent Workbench without turning it into a noisy set of unrelated chats.

## 1. Parallel Research

Use this when you want several independent readings of the same question.

1. Put the shared question in `~/AgentWorkbench/Idea/question.md`.
2. Open 4 or 9 panes.
3. Assign each pane a different angle:
   - evidence
   - risks
   - alternatives
   - implementation plan
   - user-facing explanation
4. Ask each pane to write its output to a separate markdown file.
5. Merge only the best findings into a final brief.

Useful output convention:

```text
Idea/
  question.md
  findings-evidence.md
  findings-risks.md
  findings-alternatives.md
  final-brief.md
```

## 2. Competing Hypotheses

Use this when you are not sure which explanation or product direction is right.

Give each pane one hypothesis and ask it to falsify its own case before defending it.

Example:

```text
Pane 1: Hypothesis A is correct. Find supporting evidence and weak points.
Pane 2: Hypothesis B is correct. Find supporting evidence and weak points.
Pane 3: Both are wrong. Propose a third explanation.
Pane 4: Judge the outputs and produce a decision memo.
```

## 3. Feature Discovery

Use this when planning an app or OSS tool.

```text
Pane 1: user workflow
Pane 2: implementation risks
Pane 3: README/API design
Pane 4: tests and acceptance criteria
Pane 5: security and privacy review
Pane 6: release checklist
```

Keep all outputs in the shared idea folder so the final synthesis has real files to inspect.

## 4. Small Task Mode

Use fewer panes for small tasks. Nine panes are useful for broad exploration, but overkill for a narrow fix.

```bash
AGENT_WORKBENCH_PANE_COUNT=4 ./scripts/launch_codex_tmux.sh
```

Decision rule:

- 1 pane: direct implementation
- 4 panes: small research or design decision
- 6 panes: feature planning
- 9 panes: broad exploration, market research, or competing approaches

## 5. Safety Checklist

Before sharing output from the workbench:

- remove local paths
- remove credentials
- remove private screenshots
- remove terminal logs that contain account names or tokens
- keep generated findings separate from source code

For a portable markdown-only bundle, use:

```bash
./scripts/export_workflow.sh "$HOME/AgentWorkbench/Idea"
```

To review a shared archive safely, use:

```bash
./scripts/import_workflow.sh ./Idea-workflow-export.tar.gz
```

Before publishing the repository itself:

```bash
make test
```

See [workflow sharing](workflow-sharing.md) for the export/import safety boundaries.
