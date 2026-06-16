#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v rg >/dev/null 2>&1; then
  echo "ripgrep is required: brew install ripgrep"
  exit 1
fi

home_path_pattern='/'"Users"'/[A-Za-z0-9._-]+'
github_classic_pattern='ghp_''[A-Za-z0-9_]+'
github_fine_grained_pattern='github_pat_''[A-Za-z0-9_]+'
openai_key_pattern='sk-''[A-Za-z0-9_-]+'
openai_env='OPENAI_''API_KEY'
anthropic_env='ANTHROPIC_''API_KEY'
x_env='X_''API'
twitter_env='TWITTER_''[A-Z_]+'
env_key_pattern="$openai_env|$anthropic_env|$x_env|$twitter_env"
private_key_pattern='BEGIN (RSA|OPENSSH|EC) PRIVATE KEY'
pattern="$home_path_pattern|$github_classic_pattern|$github_fine_grained_pattern|$openai_key_pattern|$env_key_pattern|$private_key_pattern"

if rg -n --hidden \
  --glob '!.git/**' \
  --glob '!Assets/*.icns' \
  --glob '!Assets/*.png' \
  --glob '!Assets/*.iconset/**' \
  "$pattern" .; then
  echo
  echo "Potential private data found. Review the matches above before publishing."
  exit 1
fi

if find . -type f \( -name '.env' -o -name '.env.*' -o -name '*.sqlite' -o -name '*.sqlite3' -o -name '*.db' -o -name '*.log' \) | grep -q .; then
  echo "Local-only files were found. Remove them before publishing:"
  find . -type f \( -name '.env' -o -name '.env.*' -o -name '*.sqlite' -o -name '*.sqlite3' -o -name '*.db' -o -name '*.log' \)
  exit 1
fi

echo "Public safety audit passed."
