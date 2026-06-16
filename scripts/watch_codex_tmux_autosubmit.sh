#!/usr/bin/env bash
set -euo pipefail

SESSION_NAME="${AGENT_WORKBENCH_SESSION:-${CODEX_WORKBENCH_SESSION:-local-agent-9}}"
AUTO_SUBMIT_DELAY="${AGENT_WORKBENCH_AUTO_SUBMIT_DELAY:-${CODEX_WORKBENCH_AUTO_SUBMIT_DELAY:-4}}"
TMUX_BIN="${TMUX_BIN:-/opt/homebrew/bin/tmux}"
STATE_DIR="${TMPDIR:-/tmp}/agent-workbench-autosubmit-$SESSION_NAME"

mkdir -p "$STATE_DIR"
rm -f "$STATE_DIR"/pane-*.state "$STATE_DIR"/pane-*.sent 2>/dev/null || true

extract_draft() {
  python3 -c '
import re
import sys

lines = sys.stdin.read().splitlines()
draft = ""
collecting = False
for line in lines:
    if line.startswith("› "):
        draft = line[2:]
        collecting = True
        continue
    if collecting and line.startswith("  ") and len(line.strip()) > 0:
        stripped = line.strip()
        if stripped.startswith("gpt-") or "· ~/" in stripped:
            collecting = False
            continue
        draft += " " + stripped
        continue
    if collecting and not line.strip():
        collecting = False

print(re.sub(r"\s+", " ", draft).strip())
'
}

is_placeholder() {
  local draft="$1"
  case "$draft" in
    ""|\
    "Summarize recent commits"|\
    "Explain this codebase"|\
    "Implement {feature}"|\
    "Run /review on my current changes")
      return 0
      ;;
  esac
  return 1
}

while "$TMUX_BIN" has-session -t "$SESSION_NAME" 2>/dev/null; do
  while IFS= read -r pane_id; do
    target="$SESSION_NAME:0.$pane_id"
    capture="$("$TMUX_BIN" capture-pane -t "$target" -p -S -80 2>/dev/null || true)"

    if printf '%s\n' "$capture" | grep -Eq '• Working|esc to interrupt|Press enter to continue|Do you trust'; then
      continue
    fi

    draft="$(printf '%s\n' "$capture" | extract_draft)"
    if is_placeholder "$draft"; then
      continue
    fi

    digest="$(printf '%s' "$draft" | shasum | awk '{print $1}')"
    state_file="$STATE_DIR/pane-$pane_id.state"
    sent_file="$STATE_DIR/pane-$pane_id.sent"
    now="$(date +%s)"

    if [[ -f "$sent_file" ]] && [[ "$(cat "$sent_file")" == "$digest" ]]; then
      continue
    fi

    if [[ -f "$state_file" ]]; then
      read -r previous_digest first_seen < "$state_file" || true
      if [[ "$previous_digest" == "$digest" ]] && (( now - first_seen >= AUTO_SUBMIT_DELAY )); then
        "$TMUX_BIN" send-keys -t "$target" Enter
        printf '%s' "$digest" > "$sent_file"
        rm -f "$state_file"
      elif [[ "$previous_digest" == "$digest" ]]; then
        printf '%s %s\n' "$digest" "$first_seen" > "$state_file"
      else
        printf '%s %s\n' "$digest" "$now" > "$state_file"
      fi
    else
      printf '%s %s\n' "$digest" "$now" > "$state_file"
    fi
  done < <("$TMUX_BIN" list-panes -t "$SESSION_NAME:0" -F '#{pane_index}' 2>/dev/null || true)

  sleep 1
done
