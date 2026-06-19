# Reviewer Quick Check

Use this page when you want to evaluate Local Agent Workbench quickly without reading every file.

## 5-minute review path

1. Read the top of [README.md](../README.md) to understand the purpose.
2. Open [Start Here](START_HERE.md) to see the first-time user path.
3. Open [Use Cases](USE_CASES.md) to confirm the OSS maintenance workflows.
4. Review the example outputs in [examples/README.md](../examples/README.md).
5. Check [Recent Improvements](recent-improvements.md) to see active maintenance.

## Codex for OSS fit

This project is a practical Codex for OSS fit because it focuses on recurring maintainer work:

- issue triage
- pull request review
- release preparation
- security triage
- documentation improvement
- dependency update review

The workbench keeps those tasks local, role-based, and reviewable. It does not auto-merge code or bypass human maintainer judgment.

## What to run

```bash
git clone https://github.com/goonobu-dot/local-agent-workbench.git
cd local-agent-workbench
./scripts/doctor.sh
make demo
```

If you only want to inspect expected output, read [docs/demo-transcript.md](demo-transcript.md) and the reviewer walkthrough in [examples/codex-for-oss-reviewer-walkthrough](../examples/codex-for-oss-reviewer-walkthrough).

## What good evidence looks like

Good evidence is not a vague AI demo. Good evidence is a folder with:

- a clear maintainer question
- role-specific pane notes
- a final handoff summary
- an issue triage, PR review, release checklist, or documentation plan
- commands or manual checks a human maintainer can verify
