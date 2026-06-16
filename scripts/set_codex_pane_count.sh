#!/usr/bin/env bash
set -euo pipefail

target_count="${1:-${AGENT_WORKBENCH_PANE_COUNT:-${CODEX_WORKBENCH_PANE_COUNT:-9}}}"
SESSION_NAME="${AGENT_WORKBENCH_SESSION:-${CODEX_WORKBENCH_SESSION:-local-agent-9}}"
CODEX_COMMAND="${AGENT_WORKBENCH_COMMAND:-${CODEX_WORKBENCH_COMMAND:-}}"
CODEX_MODEL="${AGENT_WORKBENCH_MODEL:-${CODEX_WORKBENCH_MODEL:-gpt-5.4-mini}}"
CODEX_PROMPT="${AGENT_WORKBENCH_PROMPT:-${CODEX_WORKBENCH_PROMPT:-}}"
CODEX_CHECK_FOR_UPDATE="${AGENT_WORKBENCH_CHECK_FOR_UPDATE:-${CODEX_WORKBENCH_CHECK_FOR_UPDATE:-0}}"
TMUX_BIN="${TMUX_BIN:-/opt/homebrew/bin/tmux}"
BASE_DIR="${AGENT_WORKBENCH_BASE:-${CODEX_WORKBENCH_BASE:-$HOME/AgentWorkbench}}"
IDEA_DIR="${AGENT_WORKBENCH_IDEA_DIR:-${CODEX_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}}"

if [[ ! "$target_count" =~ ^[0-9]+$ ]] || (( target_count < 1 || target_count > 12 )); then
  echo "Pane count must be between 1 and 12."
  exit 1
fi

if [[ -z "$CODEX_COMMAND" ]]; then
  for candidate in \
    "$HOME/.nvm/versions/node/v24.15.0/bin/codex" \
    "$HOME/.nvm/versions/node/v24.14.0/bin/codex" \
    /opt/homebrew/bin/codex \
    /usr/local/bin/codex \
    codex; do
    if command -v "$candidate" >/dev/null 2>&1; then
      CODEX_COMMAND="$(command -v "$candidate")"
      break
    fi
  done
fi

AGENT_WORKBENCH_PANE_COUNT="$target_count"
export AGENT_WORKBENCH_PANE_COUNT

if ! "$TMUX_BIN" has-session -t "$SESSION_NAME" 2>/dev/null; then
  AGENT_WORKBENCH_PANE_COUNT="$target_count" AGENT_WORKBENCH_ATTACH=0 "$(dirname "$0")/launch_codex_tmux.sh"
  exit 0
fi

pane_command() {
  local pane_number="$1"
  local pane_name="Agent $pane_number"
  local workspace="$IDEA_DIR"
  local trust_flag="projects.\"$workspace\".trust_level=\"trusted\""
  local quiet_plugin_flag="plugins.\"build-web-data-visualization@openai-curated\".enabled=false"

  local update_flag="check_for_update_on_startup=false"
  if [[ "$CODEX_CHECK_FOR_UPDATE" == "1" ]]; then
    update_flag="check_for_update_on_startup=true"
  fi

  if [[ -n "$CODEX_MODEL" && -n "$CODEX_PROMPT" ]]; then
    printf 'clear; printf "\\033]0;%s\\007"; echo "%s"; echo "tmux: prefix+z zoom, prefix+4/6/9 relayout"; exec %q --disable plugins -c %q -c %q -c %q --model %q %q' \
      "$pane_name" "$pane_name" "$CODEX_COMMAND" "$update_flag" "$trust_flag" "$quiet_plugin_flag" "$CODEX_MODEL" "$CODEX_PROMPT"
  elif [[ -n "$CODEX_MODEL" ]]; then
    printf 'clear; printf "\\033]0;%s\\007"; echo "%s"; echo "tmux: prefix+z zoom, prefix+4/6/9 relayout"; exec %q --disable plugins -c %q -c %q -c %q --model %q' \
      "$pane_name" "$pane_name" "$CODEX_COMMAND" "$update_flag" "$trust_flag" "$quiet_plugin_flag" "$CODEX_MODEL"
  elif [[ -n "$CODEX_PROMPT" ]]; then
    printf 'clear; printf "\\033]0;%s\\007"; echo "%s"; echo "tmux: prefix+z zoom, prefix+4/6/9 relayout"; exec %q --disable plugins -c %q -c %q -c %q %q' \
      "$pane_name" "$pane_name" "$CODEX_COMMAND" "$update_flag" "$trust_flag" "$quiet_plugin_flag" "$CODEX_PROMPT"
  else
    printf 'clear; printf "\\033]0;%s\\007"; echo "%s"; echo "tmux: prefix+z zoom, prefix+4/6/9 relayout"; exec %q --disable plugins -c %q -c %q -c %q' \
      "$pane_name" "$pane_name" "$CODEX_COMMAND" "$update_flag" "$trust_flag" "$quiet_plugin_flag"
  fi
}

current_count="$("$TMUX_BIN" list-panes -t "$SESSION_NAME:0" | wc -l | tr -d ' ')"

while (( current_count > target_count )); do
  pane_id="$("$TMUX_BIN" list-panes -t "$SESSION_NAME:0" -F '#{pane_index}' | tail -n 1)"
  "$TMUX_BIN" kill-pane -t "$SESSION_NAME:0.$pane_id"
  current_count=$((current_count - 1))
done

while (( current_count < target_count )); do
  next_number=$((current_count + 1))
  workspace="$IDEA_DIR"
  mkdir -p "$workspace"
  "$TMUX_BIN" split-window -t "$SESSION_NAME:0" -c "$workspace" "/bin/zsh" "-lc" "$(pane_command "$next_number")"
  current_count=$((current_count + 1))
done

"$TMUX_BIN" rename-window -t "$SESSION_NAME:0" "Agents $target_count" >/dev/null
"$TMUX_BIN" select-layout -t "$SESSION_NAME:0" tiled >/dev/null
"$TMUX_BIN" display-message -t "$SESSION_NAME" "Agent workbench relayout: $target_count panes"
