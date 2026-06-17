# Contributing

Contributions are welcome when they keep the workbench small, local-first, and easy to audit.

Useful areas:

- adapters for other local agent CLIs
- safer launch defaults
- clearer docs for parallel research workflows
- tests for tmux layout behavior
- macOS app packaging improvements

Before opening a pull request:

```bash
make test
```

Use `make doctor` for local setup checks and `make install-smoke` when changing installer behavior.

Do not include private logs, local vaults, or generated research output. If a contribution adds a generated workflow example, keep it fictional and run `make safety` before opening the pull request. Use `scripts/export_workflow.sh` when sharing a workflow folder outside your machine.
