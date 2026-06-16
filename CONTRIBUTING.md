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
./Tests/test_codex_workbench_config.sh
./scripts/audit_public_safety.sh
```

Do not include private logs, local vaults, or generated research output.
