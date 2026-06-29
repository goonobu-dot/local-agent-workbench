# Public AI Workflow Portfolio

This page summarizes the public AI workflow projects maintained by
`goonobu-dot`. It is supporting evidence for reviewers who want to understand
the broader public work around Codex, AI agents, OSS maintenance, and practical
automation.

The primary Codex for Open Source repository remains
[`local-agent-workbench`](https://github.com/goonobu-dot/local-agent-workbench).
The other repositories below are supporting evidence, not a replacement for
that focus.

## Primary OSS Maintenance Project

### local-agent-workbench

Repository:
https://github.com/goonobu-dot/local-agent-workbench

Purpose:
Run up to 9 local Codex CLI sessions in one tmux window so maintainers can
split issue triage, pull request review, release preparation, security
screening, documentation cleanup, and feature discovery across role-specific
agent panes.

Why it fits Codex for Open Source:

- It focuses on recurring OSS maintainer work.
- It keeps the final decision with the human maintainer.
- It stores reviewable Markdown evidence in a local workflow folder.
- It includes beginner guides, examples, CI checks, safety checks, and reviewer
  walkthroughs.

## Related Maintainer Tools

### codex-maintainer-kit

Repository:
https://github.com/goonobu-dot/codex-maintainer-kit

Purpose:
Generate maintainer briefs, Codex-ready task lists, and issue drafts from a
repository scan.

How it supports the primary project:
It turns repository state into concrete maintainer tasks that can be reviewed
and then handed to Codex or another AI agent.

### codex-maintainer-action

Repository:
https://github.com/goonobu-dot/codex-maintainer-action

Purpose:
Run the maintainer-kit workflow from GitHub Actions so maintenance artifacts can
be produced from CI or scheduled workflows.

How it supports the primary project:
It shows that the maintainer workflow can move beyond a local demo and become a
repeatable OSS maintenance routine.

## Related AI Workbench Project

### claude-code-workbench

Repository:
https://github.com/goonobu-dot/claude-code-workbench

Purpose:
Run multiple Claude Code CLI sessions in a local tmux workbench for research,
planning, and review workflows.

How it supports the primary project:
It shows that the workbench pattern is not a one-off script. The same local,
role-based, human-reviewed workflow can be adapted across AI coding tools.

## Related Practical Automation Project

### ai-automation-starter-kit

Repository:
https://github.com/goonobu-dot/ai-automation-starter-kit

Purpose:
Help people evaluate public OSS projects as candidates for practical business
automation, including usefulness, safety, licensing, review ownership, risk,
and measurement.

How it supports the primary project:
It demonstrates a broader public effort to make AI-agent workflows usable by
non-experts. It also documents safety checks, onboarding material, and
decision-making templates that complement the OSS maintainer workflow.

## Portfolio Pattern

Across these repositories, the repeated pattern is:

1. Convert vague AI-agent work into a concrete workflow.
2. Keep outputs reviewable as Markdown, issues, reports, or checklists.
3. Add beginner-friendly docs so non-experts can understand the purpose.
4. Avoid autonomous merge or production changes without human review.
5. Publish safety checks, examples, and reproducible commands.

This is the main reason the portfolio is relevant to Codex for Open Source:
the work is not only about creating code. It is about making AI-assisted
maintenance easier to inspect, repeat, and safely reuse.
