# Reviewer Terminal Transcript

This transcript shows the safe review path for Local Agent Workbench. It is written with fictional output and public-safe paths so a reviewer can understand the flow before running commands.

## 1. Clone and enter the repository

```bash
git clone https://github.com/goonobu-dot/local-agent-workbench.git
cd local-agent-workbench
```

Expected review result:

```text
Repository cloned.
Current directory: local-agent-workbench
```

## 2. Check local prerequisites

```bash
./scripts/doctor.sh
```

Expected review result:

```text
Local Agent Workbench doctor
Suggested fixes:
- Install tmux if it is missing.
- Set AGENT_WORKBENCH_COMMAND if Codex CLI is not on PATH.
```

The doctor can report missing optional tools. That does not prevent reading the examples or reviewing the repository structure.

## 3. Create a demo workflow

```bash
make demo
```

Expected review result:

```text
Demo workflow ready
```

The demo uses fictional workflow content. It does not require private project files.

## 4. Inspect workflow status

```bash
./scripts/workflow_status.sh "$HOME/AgentWorkbench/Idea"
```

Expected review result:

```text
# Workflow Status

- Workflow directory: `~/AgentWorkbench/Idea`
- Markdown file count: 4
- Pane prompt count: 9
- Handoff summary: missing

## Required files

- [x] `README.md`
- [x] `question.md`
- [x] `pane-roles.md`
```

This status view was added after reviewing public tmux orchestration projects that emphasize heartbeat and status visibility. Local Agent Workbench keeps the same visibility goal but avoids adding a daemon or dashboard.

## 5. Close the workflow into a handoff

```bash
./scripts/close_workflow.sh "$HOME/AgentWorkbench/Idea"
```

Expected review result:

```text
created: ~/AgentWorkbench/Idea/handoff-summary.md
```

The handoff summary lists markdown files, open checkboxes, empty sections, and the next review step.

## 6. Validate before sharing

```bash
./scripts/validate_workflow.sh "$HOME/AgentWorkbench/Idea"
```

Expected review result:

```text
Workflow validation passed
```

Validation should be run before exporting or sharing a workflow folder. It helps avoid accidentally publishing local paths or secret-like strings.

## 7. Reviewer conclusion

Expected review result:

```text
The project provides a local, repeatable, human-reviewed workflow for Codex-assisted OSS maintenance.
It includes onboarding docs, use cases, examples, safety checks, CI, and a public-safe reviewer path.
```
