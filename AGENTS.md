# Agent Instructions

This repository is intended for public release.

Rules for AI coding agents:

- Do not commit secrets, tokens, `.env` files, logs, databases, or personal vault content.
- Keep changes local-first and easy to audit.
- Prefer small shell scripts over hidden background services.
- Preserve compatibility with the `AGENT_WORKBENCH_*` environment variables.
- Run `./Tests/test_codex_workbench_config.sh` before claiming the repo is ready.
