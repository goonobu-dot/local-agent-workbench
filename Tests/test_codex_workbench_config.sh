#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail=0

check_contains() {
  local file="$1"
  local expected="$2"
  if ! grep -Fq -- "$expected" "$file"; then
    echo "missing in $file: $expected"
    fail=1
  fi
}

check_not_contains() {
  local file="$1"
  local unexpected="$2"
  if grep -Fq -- "$unexpected" "$file"; then
    echo "unexpected in $file: $unexpected"
    fail=1
  fi
}

check_contains scripts/launch_codex_tmux.sh 'PANE_COUNT="${AGENT_WORKBENCH_PANE_COUNT:-${CODEX_WORKBENCH_PANE_COUNT:-9}}"'
check_contains scripts/launch_codex_tmux.sh 'SESSION_NAME="${AGENT_WORKBENCH_SESSION:-${CODEX_WORKBENCH_SESSION:-local-agent-9}}"'
check_contains scripts/launch_codex_tmux.sh 'CODEX_COMMAND="${AGENT_WORKBENCH_COMMAND:-${CODEX_WORKBENCH_COMMAND:-}}"'
check_contains scripts/launch_codex_tmux.sh 'CODEX_MODEL="${AGENT_WORKBENCH_MODEL:-${CODEX_WORKBENCH_MODEL:-gpt-5.4-mini}}"'
check_contains scripts/launch_codex_tmux.sh 'IDEA_DIR="${AGENT_WORKBENCH_IDEA_DIR:-${CODEX_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}}"'
check_contains scripts/launch_codex_tmux.sh 'mkdir -p "$BASE_DIR" "$IDEA_DIR"'
check_contains scripts/launch_codex_tmux.sh 'workspace="$IDEA_DIR"'
check_contains scripts/launch_codex_tmux.sh '$HOME/.nvm/versions/node/v24.15.0/bin/codex'
check_contains scripts/launch_codex_tmux.sh 'CODEX_CHECK_FOR_UPDATE="${AGENT_WORKBENCH_CHECK_FOR_UPDATE:-${CODEX_WORKBENCH_CHECK_FOR_UPDATE:-0}}"'
check_contains scripts/launch_codex_tmux.sh 'AUTO_SUBMIT="${AGENT_WORKBENCH_AUTO_SUBMIT:-${CODEX_WORKBENCH_AUTO_SUBMIT:-1}}"'
check_contains scripts/launch_codex_tmux.sh 'check_for_update_on_startup=false'
check_contains scripts/launch_codex_tmux.sh '--disable plugins'
check_contains scripts/launch_codex_tmux.sh 'trust_level=\"trusted\"'
check_contains scripts/launch_codex_tmux.sh 'build-web-data-visualization@openai-curated'
check_contains scripts/launch_codex_tmux.sh 'elif [[ -n "$CODEX_PROMPT" ]]; then'
check_contains scripts/launch_codex_tmux.sh 'exec %q'
check_contains scripts/launch_codex_tmux.sh 'bind-key z resize-pane -Z'
check_contains scripts/launch_codex_tmux.sh 'bind-key 4 run-shell'
check_contains scripts/launch_codex_tmux.sh 'bind-key 6 run-shell'
check_contains scripts/launch_codex_tmux.sh 'bind-key 9 run-shell'
check_contains scripts/launch_codex_tmux.sh 'split-window'
check_contains scripts/launch_codex_tmux.sh 'select-layout -t "$SESSION_NAME:0" tiled'
check_contains scripts/launch_codex_tmux.sh 'pane-border-style'
check_contains scripts/launch_codex_tmux.sh 'pane-active-border-style'
check_contains scripts/launch_codex_tmux.sh 'zoom: C-b z'
check_contains scripts/launch_codex_tmux.sh 'trap cleanup_session EXIT HUP INT TERM'
check_contains scripts/launch_codex_tmux.sh 'trust_codex_workbench_dirs.sh'
check_contains scripts/launch_codex_tmux.sh 'watch_codex_tmux_autosubmit.sh'
check_contains scripts/launch_codex_tmux.sh 'nohup env'
check_contains scripts/watch_codex_tmux_autosubmit.sh 'AUTO_SUBMIT_DELAY="${AGENT_WORKBENCH_AUTO_SUBMIT_DELAY:-${CODEX_WORKBENCH_AUTO_SUBMIT_DELAY:-4}}"'
check_contains scripts/watch_codex_tmux_autosubmit.sh 'Summarize recent commits'
check_contains scripts/watch_codex_tmux_autosubmit.sh 'send-keys -t "$target" Enter'
check_contains scripts/set_codex_pane_count.sh 'AGENT_WORKBENCH_PANE_COUNT="$target_count"'
check_contains scripts/set_codex_pane_count.sh 'IDEA_DIR="${AGENT_WORKBENCH_IDEA_DIR:-${CODEX_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}}"'
check_contains scripts/set_codex_pane_count.sh 'workspace="$IDEA_DIR"'
check_contains scripts/trust_codex_workbench_dirs.sh '[projects.\"$workspace\"]'
check_contains scripts/trust_codex_workbench_dirs.sh 'trust_level = "trusted"'
check_contains scripts/trust_codex_workbench_dirs.sh 'IDEA_DIR="${AGENT_WORKBENCH_IDEA_DIR:-${CODEX_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}}"'
check_contains scripts/build_codex_app.sh 'APP_BUNDLE="${AGENT_WORKBENCH_APP_BUNDLE:-${CODEX_WORKBENCH_APP_BUNDLE:-$HOME/Applications/Local Agent Workbench.app}}"'
check_contains scripts/build_codex_app.sh 'AGENT_WORKBENCH_REGENERATE_ICON'
check_contains scripts/build_codex_app.sh 'CodexCLI9Panes'
check_contains scripts/build_codex_app.sh 'create_codex_icon.py'
check_contains scripts/build_codex_app.sh 'cp "$ICON_FILE" "$APP_BUNDLE/Contents/Resources/$ICON_NAME.icns"'
check_contains scripts/build_codex_app.sh 'Set :CFBundleIconFile $ICON_NAME'
check_contains scripts/build_codex_app.sh 'find "$bundle_path" -print0 | xargs -0 -n1 /usr/bin/xattr -c'
check_contains scripts/build_codex_app.sh '/usr/bin/xattr -c "$path"'
check_contains scripts/launch_codex_tmux.applescript 'Local Agent Workbench'
check_contains scripts/launch_codex_tmux.applescript 'system attribute "AGENT_WORKBENCH_SCRIPT"'
check_contains scripts/launch_codex_tmux.applescript 'set bounds of front window'
check_contains scripts/create_codex_icon.py 'CodexCLI9Panes.iconset'
check_contains scripts/create_codex_icon.py 'draw_rounded_rectangle'
check_contains scripts/create_codex_icon.py 'CODEX'
check_contains scripts/create_codex_icon.py '9'
check_contains scripts/doctor.sh 'Local Agent Workbench doctor'
check_contains scripts/install.sh 'Local Agent Workbench installer'
check_contains scripts/install.sh 'AGENT_WORKBENCH_INSTALL_DIR'
check_contains scripts/new_workflow.sh 'issue-triage'
check_contains scripts/new_workflow.sh 'AGENT_WORKBENCH_IDEA_DIR'
check_contains scripts/close_workflow.sh 'Workflow Handoff Summary'
check_contains scripts/close_workflow.sh 'Empty Sections To Fill'
check_contains README.md 'docs/oss-maintainer-use-cases.md'
check_contains README.md 'docs/showcase.md'
check_contains README.md 'docs/workflow-templates.md'
check_contains README.md 'docs/openai-codex-for-oss.md'
check_contains README.md 'docs/adoption-plan.md'
check_contains README.md 'examples/issue-triage-demo'
check_contains README.md 'ROADMAP.md'
check_contains ROADMAP.md 'Near-Term Improvements'
check_contains CHANGELOG.md 'v0.5.0'
check_contains docs/openai-codex-for-oss.md 'How API Credits Would Help'
check_contains docs/adoption-plan.md 'Do not fake adoption'
check_contains examples/README.md 'issue-triage-demo'
check_contains examples/README.md 'pr-review-demo'
check_contains examples/issue-triage-demo/README.md 'Fictional demo'
check_contains examples/issue-triage-demo/final-triage.md 'Recommended Fix'
check_contains examples/issue-triage-demo/handoff-summary.md 'Workflow Handoff Summary'
check_contains examples/pr-review-demo/README.md 'Fictional demo'
check_contains examples/pr-review-demo/final-review.md 'Review Verdict'
check_contains examples/pr-review-demo/handoff-summary.md 'Workflow Handoff Summary'
check_not_contains scripts/launch_codex_tmux.sh 'Claude Code'
check_not_contains scripts/launch_codex_tmux.sh 'claude-code'
check_not_contains scripts/launch_codex_tmux.sh 'Idea-$pane_number'
check_not_contains scripts/set_codex_pane_count.sh 'Idea-$next_number'
check_not_contains scripts/trust_codex_workbench_dirs.sh 'Idea-$pane_number'
check_not_contains scripts/build_codex_app.sh 'Claude Code'
private_home='/'"Users"'/admin'
check_not_contains scripts/launch_codex_tmux.applescript "$private_home"
check_not_contains README.md "$private_home"

exit "$fail"
