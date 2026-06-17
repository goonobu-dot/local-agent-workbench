#!/usr/bin/env bash
set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR" || exit 1

echo "Local Agent Workbench doctor"
echo

fail=0
recommendations=()

add_recommendation() {
  recommendations+=("$1")
}

check_command() {
  local label="$1"
  local command_name="$2"
  local advice="${3:-}"
  if command -v "$command_name" >/dev/null 2>&1; then
    printf "ok   %-18s %s\n" "$label" "$(command -v "$command_name")"
  else
    printf "miss %-18s %s\n" "$label" "$command_name"
    if [[ -n "$advice" ]]; then
      add_recommendation "$advice"
    fi
    fail=1
  fi
}

check_file() {
  local path="$1"
  if [[ -f "$path" ]]; then
    printf "ok   %-18s %s\n" "file" "$path"
  else
    printf "miss %-18s %s\n" "file" "$path"
    add_recommendation "Reinstall or update the checkout: ./scripts/install.sh"
    fail=1
  fi
}

check_command "tmux" "${TMUX_BIN:-tmux}" "Install tmux with Homebrew: brew install tmux"

if [[ -n "${AGENT_WORKBENCH_COMMAND:-${CODEX_WORKBENCH_COMMAND:-}}" ]]; then
  candidate="${AGENT_WORKBENCH_COMMAND:-${CODEX_WORKBENCH_COMMAND:-}}"
  if command -v "$candidate" >/dev/null 2>&1; then
    printf "ok   %-18s %s\n" "agent command" "$(command -v "$candidate")"
  else
    printf "miss %-18s %s\n" "agent command" "$candidate"
    add_recommendation "Set AGENT_WORKBENCH_COMMAND to a valid Codex CLI path, or put codex on PATH."
    fail=1
  fi
else
  check_command "codex" "codex" "Install Codex CLI or set AGENT_WORKBENCH_COMMAND to its full path."
fi

check_file "scripts/launch_codex_tmux.sh"
check_file "scripts/audit_public_safety.sh"
check_file "Tests/test_codex_workbench_config.sh"

echo
if ./scripts/audit_public_safety.sh >/dev/null; then
  echo "ok   public safety audit"
else
  echo "fail public safety audit"
  fail=1
fi

echo
if (( fail == 0 )); then
  echo "Ready to launch:"
  echo "  ./scripts/launch_codex_tmux.sh"
else
  echo "Fix the missing items above, then run this doctor again."
  if (( ${#recommendations[@]} > 0 )); then
    echo
    echo "Suggested fixes:"
    for recommendation in "${recommendations[@]}"; do
      echo "  - $recommendation"
    done
  fi
fi

exit "$fail"
