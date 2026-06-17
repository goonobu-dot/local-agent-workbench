#!/usr/bin/env bash
set -euo pipefail

PANE_COUNT="${AGENT_WORKBENCH_PANE_COUNT:-${CODEX_WORKBENCH_PANE_COUNT:-9}}"
SESSION_NAME="${AGENT_WORKBENCH_SESSION:-${CODEX_WORKBENCH_SESSION:-local-agent-9}}"
CODEX_COMMAND="${AGENT_WORKBENCH_COMMAND:-${CODEX_WORKBENCH_COMMAND:-}}"
CODEX_MODEL="${AGENT_WORKBENCH_MODEL:-${CODEX_WORKBENCH_MODEL:-gpt-5.4-mini}}"
CODEX_PROMPT="${AGENT_WORKBENCH_PROMPT:-${CODEX_WORKBENCH_PROMPT:-}}"
CODEX_CHECK_FOR_UPDATE="${AGENT_WORKBENCH_CHECK_FOR_UPDATE:-${CODEX_WORKBENCH_CHECK_FOR_UPDATE:-0}}"
AUTO_SUBMIT="${AGENT_WORKBENCH_AUTO_SUBMIT:-${CODEX_WORKBENCH_AUTO_SUBMIT:-1}}"
TMUX_BIN="${TMUX_BIN:-/opt/homebrew/bin/tmux}"
BASE_DIR="${AGENT_WORKBENCH_BASE:-${CODEX_WORKBENCH_BASE:-$HOME/AgentWorkbench}}"
IDEA_DIR="${AGENT_WORKBENCH_IDEA_DIR:-${CODEX_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}}"
ROLE_PROMPT_DIR="${AGENT_WORKBENCH_ROLE_PROMPT_DIR:-${CODEX_WORKBENCH_ROLE_PROMPT_DIR:-$IDEA_DIR/prompts}}"
USE_ROLE_PROMPTS="${AGENT_WORKBENCH_USE_ROLE_PROMPTS:-${CODEX_WORKBENCH_USE_ROLE_PROMPTS:-0}}"
ATTACH="${AGENT_WORKBENCH_ATTACH:-${CODEX_WORKBENCH_ATTACH:-1}}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! "$PANE_COUNT" =~ ^[0-9]+$ ]] || (( PANE_COUNT < 1 || PANE_COUNT > 12 )); then
  echo "AGENT_WORKBENCH_PANE_COUNT must be between 1 and 12."
  exit 1
fi

if [[ ! -x "$TMUX_BIN" ]]; then
  echo "tmux is not installed at $TMUX_BIN"
  echo "Install it with: brew install tmux"
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

if [[ -z "$CODEX_COMMAND" ]] || ! command -v "$CODEX_COMMAND" >/dev/null 2>&1; then
  echo "Codex CLI was not found: $CODEX_COMMAND"
  exit 1
fi

mkdir -p "$BASE_DIR" "$IDEA_DIR"
"$SCRIPT_DIR/trust_codex_workbench_dirs.sh"

if "$TMUX_BIN" has-session -t "$SESSION_NAME" 2>/dev/null; then
  "$TMUX_BIN" kill-session -t "$SESSION_NAME"
fi

cleanup_session() {
  if [[ "$ATTACH" == "1" ]] && "$TMUX_BIN" has-session -t "$SESSION_NAME" 2>/dev/null; then
    "$TMUX_BIN" kill-session -t "$SESSION_NAME" 2>/dev/null || true
  fi
}

trap cleanup_session EXIT HUP INT TERM

pane_command() {
  local pane_number="$1"
  local pane_name="Agent $pane_number"
  local workspace="$IDEA_DIR"
  local pane_prompt="$CODEX_PROMPT"
  local trust_flag="projects.\"$workspace\".trust_level=\"trusted\""
  local quiet_plugin_flag="plugins.\"build-web-data-visualization@openai-curated\".enabled=false"
  local role_prompt_file="$ROLE_PROMPT_DIR/pane-$pane_number.md"

  if [[ "$USE_ROLE_PROMPTS" == "1" && -f "$role_prompt_file" ]]; then
    if [[ -n "$pane_prompt" ]]; then
      pane_prompt="$(cat "$role_prompt_file")

$pane_prompt"
    else
      pane_prompt="$(cat "$role_prompt_file")"
    fi
  fi

  local update_flag="check_for_update_on_startup=false"
  if [[ "$CODEX_CHECK_FOR_UPDATE" == "1" ]]; then
    update_flag="check_for_update_on_startup=true"
  fi

  if [[ -n "$CODEX_MODEL" && -n "$pane_prompt" ]]; then
    printf 'clear; printf "\\033]0;%s\\007"; echo "%s"; echo "tmux: prefix+z zoom, prefix+4/6/9 relayout"; exec %q --disable plugins -c %q -c %q -c %q --model %q %q' \
      "$pane_name" "$pane_name" "$CODEX_COMMAND" "$update_flag" "$trust_flag" "$quiet_plugin_flag" "$CODEX_MODEL" "$pane_prompt"
  elif [[ -n "$CODEX_MODEL" ]]; then
    printf 'clear; printf "\\033]0;%s\\007"; echo "%s"; echo "tmux: prefix+z zoom, prefix+4/6/9 relayout"; exec %q --disable plugins -c %q -c %q -c %q --model %q' \
      "$pane_name" "$pane_name" "$CODEX_COMMAND" "$update_flag" "$trust_flag" "$quiet_plugin_flag" "$CODEX_MODEL"
  elif [[ -n "$pane_prompt" ]]; then
    printf 'clear; printf "\\033]0;%s\\007"; echo "%s"; echo "tmux: prefix+z zoom, prefix+4/6/9 relayout"; exec %q --disable plugins -c %q -c %q -c %q %q' \
      "$pane_name" "$pane_name" "$CODEX_COMMAND" "$update_flag" "$trust_flag" "$quiet_plugin_flag" "$pane_prompt"
  else
    printf 'clear; printf "\\033]0;%s\\007"; echo "%s"; echo "tmux: prefix+z zoom, prefix+4/6/9 relayout"; exec %q --disable plugins -c %q -c %q -c %q' \
      "$pane_name" "$pane_name" "$CODEX_COMMAND" "$update_flag" "$trust_flag" "$quiet_plugin_flag"
  fi
}

for pane_number in $(seq 1 "$PANE_COUNT"); do
  workspace="$IDEA_DIR"
  mkdir -p "$workspace"
  if [[ "$pane_number" == "1" ]]; then
    "$TMUX_BIN" new-session -d -s "$SESSION_NAME" -n "Agents $PANE_COUNT" -c "$workspace" "/bin/zsh" "-lc" "$(pane_command "$pane_number")"
  else
    "$TMUX_BIN" split-window -t "$SESSION_NAME:0" -c "$workspace" "/bin/zsh" "-lc" "$(pane_command "$pane_number")"
    "$TMUX_BIN" select-layout -t "$SESSION_NAME:0" tiled >/dev/null
  fi
done

"$TMUX_BIN" select-layout -t "$SESSION_NAME:0" tiled >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" mouse on >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" status on >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" status-style "bg=#0f172a,fg=#dbeafe" >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" status-left "#[fg=#67e8f9,bold] Agents $PANE_COUNT #[fg=#dbeafe] " >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" status-right "#[fg=#bfdbfe]zoom: C-b z  panes: C-b 4 6 9 #[fg=#67e8f9]%H:%M " >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" pane-border-style "fg=#334155" >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" pane-active-border-style "fg=#22d3ee" >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" remain-on-exit on >/dev/null
"$TMUX_BIN" bind-key z resize-pane -Z
"$TMUX_BIN" bind-key 4 run-shell "AGENT_WORKBENCH_PANE_COUNT=4 AGENT_WORKBENCH_SESSION=$SESSION_NAME AGENT_WORKBENCH_ATTACH=0 '$SCRIPT_DIR/set_codex_pane_count.sh' 4"
"$TMUX_BIN" bind-key 6 run-shell "AGENT_WORKBENCH_PANE_COUNT=6 AGENT_WORKBENCH_SESSION=$SESSION_NAME AGENT_WORKBENCH_ATTACH=0 '$SCRIPT_DIR/set_codex_pane_count.sh' 6"
"$TMUX_BIN" bind-key 9 run-shell "AGENT_WORKBENCH_PANE_COUNT=9 AGENT_WORKBENCH_SESSION=$SESSION_NAME AGENT_WORKBENCH_ATTACH=0 '$SCRIPT_DIR/set_codex_pane_count.sh' 9"

if [[ "$AUTO_SUBMIT" == "1" ]]; then
  nohup env \
    AGENT_WORKBENCH_SESSION="$SESSION_NAME" \
    AGENT_WORKBENCH_AUTO_SUBMIT_DELAY="${AGENT_WORKBENCH_AUTO_SUBMIT_DELAY:-${CODEX_WORKBENCH_AUTO_SUBMIT_DELAY:-4}}" \
    TMUX_BIN="$TMUX_BIN" \
    "$SCRIPT_DIR/watch_codex_tmux_autosubmit.sh" >/dev/null 2>&1 &
fi

if [[ "$ATTACH" == "1" ]]; then
  "$TMUX_BIN" attach-session -t "$SESSION_NAME"
else
  "$TMUX_BIN" list-panes -t "$SESSION_NAME:0"
fi
