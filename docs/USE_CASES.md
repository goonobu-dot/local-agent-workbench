# Use Cases

Use this page when you understand the project but are unsure what to do with it.

## 1. OSS issue triage

Run several Codex CLI panes against the same issue. Let one pane reproduce the problem, one inspect code paths, one propose tests, and one draft a maintainer response.

Good output: a short triage note, reproduction status, likely code area, and next action.

## 2. Pull request review

Use separate panes for behavior, tests, security, compatibility, docs, and release notes. This keeps review comments more structured than a single long chat.

Good output: a review verdict with blockers, risks, and suggested follow-up.

## 3. Release preparation

Split release work across changelog, compatibility, smoke tests, docs, release notes, and follow-ups.

Good output: a release checklist that a maintainer can verify before tagging.

## 4. Feature discovery

Ask panes to explore user workflow, implementation paths, CLI design, and testing strategy. Compare the outputs before deciding what to build.

Good output: a decision memo with one recommended path and rejected alternatives.

## 5. Security or dependency review

Use the workbench for parallel risk checks before changing dependencies or accepting security-sensitive changes.

Good output: a risk summary, manual review items, and commands to verify the change.

## What To Try First

If you are not sure, start with issue triage. It is concrete, easy to judge, and shows why multiple panes can help.
