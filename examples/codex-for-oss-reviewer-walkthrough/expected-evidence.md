# Expected Evidence

This page lists the evidence a reviewer can inspect without running a private workflow.

## Repository evidence

- `README.md` explains install, demo, examples, and safety posture.
- `docs/START_HERE.md` gives a first-time path.
- `docs/USE_CASES.md` maps the tool to maintainer workflows.
- `docs/reviewer-quick-check.md` gives a 5-minute review path.
- `docs/recent-improvements.md` shows active public maintenance.
- `.github/workflows/ci.yml` runs validation on pushes.

## Workflow evidence

- `examples/issue-triage-demo/final-triage.md` shows issue triage output.
- `examples/pr-review-demo/final-review.md` shows PR review output.
- `examples/release-prep-demo/release-checklist.md` shows release preparation output.
- `examples/security-triage-demo/security-triage.md` shows security triage output.
- `examples/docs-improvement-demo/docs-plan.md` shows documentation improvement output.
- `examples/dependency-update-demo/update-review.md` shows dependency update review output.

## Safety evidence

- `scripts/audit_public_safety.sh` checks for public-sharing risks.
- `scripts/validate_workflow.sh` checks workflow folders before sharing.
- `scripts/export_workflow.sh` warns on potential private data.
- `SECURITY.md` documents secret and private-network handling.

## Maintainer evidence

The project is strongest when judged as an early but actively maintained OSS tool that is built around real maintainer workflows and human-reviewed Codex output.
