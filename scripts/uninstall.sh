#!/usr/bin/env bash
set -euo pipefail

echo "Local Agent Workbench uninstaller"

BASE_DIR="${AGENT_WORKBENCH_BASE:-${CODEX_WORKBENCH_BASE:-$HOME/AgentWorkbench}}"
INSTALL_DIR="${AGENT_WORKBENCH_INSTALL_DIR:-$BASE_DIR/local-agent-workbench}"
APP_BUNDLE="${AGENT_WORKBENCH_APP_BUNDLE:-${CODEX_WORKBENCH_APP_BUNDLE:-$HOME/Applications/Local Agent Workbench.app}}"
IDEA_DIR="${AGENT_WORKBENCH_IDEA_DIR:-${CODEX_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}}"
REMOVE_APP="${AGENT_WORKBENCH_REMOVE_APP:-0}"
REMOVE_IDEA="${AGENT_WORKBENCH_REMOVE_IDEA:-0}"
CONFIRM="${AGENT_WORKBENCH_CONFIRM_UNINSTALL:-0}"

cat <<EOF
Install directory: $INSTALL_DIR
App bundle:        $APP_BUNDLE
Idea directory:    $IDEA_DIR

This script only removes files when confirmation is explicit.
Set AGENT_WORKBENCH_CONFIRM_UNINSTALL=1 to remove the install directory.
Set AGENT_WORKBENCH_REMOVE_APP=1 to also remove the app bundle.
Set AGENT_WORKBENCH_REMOVE_IDEA=1 to also remove the idea directory.
EOF

if [[ "$CONFIRM" != "1" ]]; then
  echo "No files removed."
  exit 0
fi

rm -rf "$INSTALL_DIR"

if [[ "$REMOVE_APP" == "1" ]]; then
  rm -rf "$APP_BUNDLE"
fi

if [[ "$REMOVE_IDEA" == "1" ]]; then
  rm -rf "$IDEA_DIR"
fi

echo "Uninstall complete."
