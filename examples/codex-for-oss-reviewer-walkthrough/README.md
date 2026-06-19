# Codex for OSS Reviewer Walkthrough

This walkthrough helps a reviewer evaluate Local Agent Workbench as a Codex-assisted OSS maintenance project.

## What to inspect first

1. [Reviewer Notes](reviewer-notes.md)
2. [Expected Evidence](expected-evidence.md)
3. [Reviewer Terminal Transcript](terminal-transcript.md)
4. [Issue triage demo](../issue-triage-demo/final-triage.md)
5. [PR review demo](../pr-review-demo/final-review.md)
6. [Release prep demo](../release-prep-demo/release-checklist.md)

## Why this exists

The project is not trying to prove that multiple AI panes are impressive by themselves. The goal is to make maintainer work easier to split, compare, and review.

The useful pattern is:

1. Start from a concrete maintainer question.
2. Split the question into role-specific panes.
3. Let panes produce focused notes.
4. Close the workflow into a handoff summary.
5. Let a human maintainer decide what to merge, reject, or investigate.

## Safe review command

```bash
make demo
```

This creates a temporary fictional workflow so reviewers can inspect the output shape without exposing a private project.
