# Security

## Supported Versions

This project is currently an early public release. Security fixes are accepted on the default branch.

## Reporting A Vulnerability

Please open a private advisory or contact the maintainer directly if you find a vulnerability.

Do not publish:

- API keys or access tokens
- local prompt histories
- terminal logs
- Obsidian vault contents
- `.env` files
- generated agent output containing personal data

## Local Trust Behavior

The Codex helper script can add the shared workbench folder to the local Codex trusted-project config. Review `scripts/trust_codex_workbench_dirs.sh` before running it if you use a custom workspace path.
