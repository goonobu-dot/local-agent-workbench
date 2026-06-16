#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="${AGENT_WORKBENCH_BASE:-${CODEX_WORKBENCH_BASE:-$HOME/AgentWorkbench}}"
IDEA_DIR="${AGENT_WORKBENCH_IDEA_DIR:-${CODEX_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}}"
MAX_PANES="${AGENT_WORKBENCH_MAX_TRUSTED_PANES:-${CODEX_WORKBENCH_MAX_TRUSTED_PANES:-12}}"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
CONFIG_FILE="$CODEX_HOME_DIR/config.toml"

mkdir -p "$BASE_DIR" "$IDEA_DIR" "$CODEX_HOME_DIR"
touch "$CONFIG_FILE"

for workspace in "$IDEA_DIR"; do
  header="[projects.\"$workspace\"]"
  if ! grep -Fq "$header" "$CONFIG_FILE"; then
    {
      printf '\n%s\n' "$header"
      printf 'trust_level = "trusted"\n'
    } >> "$CONFIG_FILE"
  fi
done
