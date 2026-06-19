# External Research Notes

This project tracks useful public patterns from related GitHub projects and only adopts the parts that fit a small local OSS maintainer workflow.

## Researched patterns

| Public pattern | Why it matters | Decision |
| --- | --- | --- |
| tmux orchestration with heartbeat and status visibility | Multi-agent work is easier to trust when users can see current state, worker output, and handoff readiness. | Adopted a lightweight local version via `scripts/workflow_status.sh`. |
| File-based coordination | Plain files are easy to inspect, diff, and share without a server. | Already aligned: workflow folders contain question, roles, prompts, notes, and handoff summaries. |
| Worktree-isolated agents | Useful for large parallel coding tasks where workers might edit conflicting files. | Not adopted yet; this project currently focuses on maintainer research and review workflows. |
| Web dashboards | Helpful for teams, but heavy for a small public CLI starter. | Not adopted yet; docs, transcripts, and status output are lower-risk. |
| Agent/skill catalogs | Clear capability maps help users choose the right workflow quickly. | Partly adopted through Use Cases, workflow templates, and reviewer docs. |
| Persistent memory vaults | Useful for long-running personal workflows. | Not adopted yet; this repo keeps durable state in explicit workflow folders. |

## Adopted now

`scripts/workflow_status.sh` gives users a public-safe status snapshot:

- workflow directory
- markdown file count
- pane prompt count
- handoff summary status
- required file checklist
- markdown file list
- suggested next checks

This strengthens the project without adding a daemon, database, web server, or account system.

## Not adopted yet

The following ideas may be useful later, but should not be added until there is real demand:

- automatic heartbeat loop
- live pane dashboard
- Redis or server-based coordination
- automatic branch/worktree spawning
- persistent memory integration

The project should stay small, local, auditable, and easy for an OSS maintainer to understand.
