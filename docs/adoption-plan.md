# Adoption Plan

This project is early, so adoption depends on reducing friction and making the value obvious.

## Target Users

- open-source maintainers who already use Codex CLI
- developers experimenting with parallel AI-agent workflows
- maintainers who want structured issue triage or PR review notes
- users comfortable with macOS, Terminal, and tmux

## Adoption Hooks

1. One-command install:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/goonobu-dot/local-agent-workbench/main/scripts/install.sh | bash
   ```

2. Demo folder:

   `examples/issue-triage-demo`

3. Workflow templates:

   ```bash
   ./scripts/new_workflow.sh issue-triage
   ./scripts/new_workflow.sh pr-review
   ./scripts/new_workflow.sh release-prep
   ```

4. Handoff summary:

   ```bash
   ./scripts/close_workflow.sh "$HOME/AgentWorkbench/Idea"
   ```

## Near-Term Outreach

- Share a short X post with the Codex repository link.
- Add a screenshot or short GIF showing the tmux grid.
- Ask for feedback from developers already using Codex CLI.
- Open roadmap issues so visitors can see the project is actively maintained.

## Success Signals

- stars or forks from people outside the maintainer account
- issue comments or workflow suggestions
- clones from unique users
- PRs that improve templates or installation
- maintainers adapting the workflow to their own repos

## Principle

Do not fake adoption. Make the repository easy to understand, easy to install, and easy to evaluate. Let real usage emerge from that.
