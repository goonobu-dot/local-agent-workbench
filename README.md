# Local Agent Workbench

[![CI](https://github.com/goonobu-dot/local-agent-workbench/actions/workflows/ci.yml/badge.svg)](https://github.com/goonobu-dot/local-agent-workbench/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/goonobu-dot/local-agent-workbench)](https://github.com/goonobu-dot/local-agent-workbench/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A macOS/tmux workbench for running multiple local AI-agent CLI sessions in one window.

The first supported target is Codex CLI. The goal is simple: open 4, 6, or 9 agent panes against one shared workspace so you can collect ideas, compare approaches, run parallel research, and keep the resulting files in one place.

## Why This Exists

AI agents are useful, but one chat window is often too narrow for exploration. This workbench gives you a repeatable local setup for:

- parallel research and idea generation
- comparing multiple solution paths side by side
- keeping all panes pointed at the same project folder
- switching between 4, 6, and 9 panes without rebuilding your terminal layout
- launching the setup as a small macOS app shortcut

## Requirements

- macOS
- `tmux`
- Codex CLI available on your `PATH`
- Python 3 and Pillow only if you regenerate the icon

Install tmux with Homebrew:

```bash
brew install tmux
```

## Quick Start

One-command install:

```bash
curl -fsSL https://raw.githubusercontent.com/goonobu-dot/local-agent-workbench/main/scripts/install.sh | bash
```

Clone or copy this repository to the default local location:

```bash
mkdir -p "$HOME/AgentWorkbench"
git clone <your-fork-url> "$HOME/AgentWorkbench/local-agent-workbench"
cd "$HOME/AgentWorkbench/local-agent-workbench"
./scripts/launch_codex_tmux.sh
```

Check your local setup without starting a workbench session:

```bash
./scripts/doctor.sh
```

Create a reusable maintainer workflow folder before launching panes:

```bash
./scripts/new_workflow.sh issue-triage
AGENT_WORKBENCH_IDEA_DIR="$HOME/AgentWorkbench/Idea" ./scripts/launch_codex_tmux.sh
```

After the panes write their notes, create a handoff summary:

```bash
./scripts/close_workflow.sh "$HOME/AgentWorkbench/Idea"
```

All panes use one shared idea folder by default:

```bash
~/AgentWorkbench/Idea
```

## Controls

- `control-b z`: zoom or unzoom the active pane
- `control-b 4`: switch to 4 panes
- `control-b 6`: switch to 6 panes
- `control-b 9`: switch back to 9 panes

## Configuration

The public configuration names are `AGENT_WORKBENCH_*`. Older `CODEX_WORKBENCH_*` names are still accepted as compatibility aliases.

```bash
AGENT_WORKBENCH_PANE_COUNT=4 ./scripts/launch_codex_tmux.sh
AGENT_WORKBENCH_BASE="$HOME/AgentWorkbench" ./scripts/launch_codex_tmux.sh
AGENT_WORKBENCH_IDEA_DIR="$HOME/AgentWorkbench/Research" ./scripts/launch_codex_tmux.sh
AGENT_WORKBENCH_MODEL="gpt-5.4-mini" ./scripts/launch_codex_tmux.sh
AGENT_WORKBENCH_AUTO_SUBMIT=0 ./scripts/launch_codex_tmux.sh
```

Defaults:

| Setting | Default |
| --- | --- |
| `AGENT_WORKBENCH_PANE_COUNT` | `9` |
| `AGENT_WORKBENCH_SESSION` | `local-agent-9` |
| `AGENT_WORKBENCH_BASE` | `~/AgentWorkbench` |
| `AGENT_WORKBENCH_IDEA_DIR` | `~/AgentWorkbench/Idea` |
| `AGENT_WORKBENCH_MODEL` | `gpt-5.4-mini` |
| `AGENT_WORKBENCH_AUTO_SUBMIT` | `1` |

## Workflow Recipes

See [docs/workflows.md](docs/workflows.md) for practical patterns:

- parallel research
- competing hypotheses
- feature discovery
- small task mode
- public-output safety checks

See also:

- [docs/oss-maintainer-use-cases.md](docs/oss-maintainer-use-cases.md)
- [docs/showcase.md](docs/showcase.md)
- [docs/workflow-templates.md](docs/workflow-templates.md)
- [docs/openai-codex-for-oss.md](docs/openai-codex-for-oss.md)
- [docs/adoption-plan.md](docs/adoption-plan.md)

Example:

- [examples/issue-triage-demo](examples/issue-triage-demo)

Project operations:

- [ROADMAP.md](ROADMAP.md)
- [CHANGELOG.md](CHANGELOG.md)

## Build The macOS App

```bash
./scripts/build_codex_app.sh
open "$HOME/Applications/Local Agent Workbench.app"
```

The generated app opens Terminal and launches the tmux workbench. The checked-in AppleScript does not contain a personal path. By default, it expects this repository at:

```bash
~/AgentWorkbench/local-agent-workbench
```

## Safety Notes

This repository intentionally does not include local logs, `.env` files, prompt histories, Obsidian vaults, or generated agent output.

Before publishing your own fork, run:

```bash
./Tests/test_codex_workbench_config.sh
./scripts/audit_public_safety.sh
```

## Project Status

This is an early public release extracted from a real local workflow. The current implementation focuses on Codex CLI because that is the tested path. The naming is intentionally broader so future adapters can support other local agent CLIs without changing the project identity.
