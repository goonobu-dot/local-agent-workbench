# Recipes

Recipes are practical ways to use Local Agent Workbench. Start with one small workflow, inspect the output, then adjust the pane roles for your own work.

## 1. Research a technical topic from multiple angles

Use this when you find a new tool, library, or AI workflow and want a fast but organized evaluation.

Suggested pane split:

- Pane 1: What problem does it solve?
- Pane 2: What are the strongest examples?
- Pane 3: What are the risks or limitations?
- Pane 4: What similar projects exist?
- Pane 5: How would I try it locally?
- Pane 6: What should I ignore for now?
- Pane 7: What would make it useful for OSS maintenance?
- Pane 8: Challenge the hype.
- Pane 9: Write the final recommendation.

Good output: a short decision memo with sources, risks, and one next step.

## 2. Turn a GitHub issue into a maintainer handoff

Use this when an issue report is vague, noisy, or too large for one pass.

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123
./scripts/workflow_status.sh "$HOME/AgentWorkbench/Idea"
```

Good output: reproduction status, likely code path, proposed fix, tests, and maintainer reply.

## 3. Review a pull request without mixing concerns

Use separate panes for behavior, tests, security, compatibility, docs, release notes, and skeptical review.

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/pull/123
```

Good output: a review verdict with blockers, non-blocking suggestions, and requested tests.

## 4. Prepare a release checklist

Use this when a small project needs one final pass before tagging.

```bash
./scripts/new_workflow.sh release-prep
```

Good output: release readiness, smoke tests, known risks, release notes, and follow-up issues.

## 5. Compare feature ideas

Use this when you have several possible improvements but do not know which one is worth building.

```bash
./scripts/new_workflow.sh feature-discovery
```

Good output: one recommended scope, rejected alternatives, and a test plan.

## 6. Capture the result

After panes write notes, close the workflow:

```bash
./scripts/close_workflow.sh "$HOME/AgentWorkbench/Idea"
```

Before sharing, validate:

```bash
./scripts/validate_workflow.sh "$HOME/AgentWorkbench/Idea"
```
