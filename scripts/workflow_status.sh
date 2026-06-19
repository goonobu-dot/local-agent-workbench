#!/usr/bin/env bash
set -euo pipefail

WORKFLOW_DIR="${1:-${AGENT_WORKBENCH_IDEA_DIR:-${CODEX_WORKBENCH_IDEA_DIR:-$HOME/AgentWorkbench/Idea}}}"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/workflow_status.sh [workflow-dir]

Prints a public-safe status summary for a Local Agent Workbench workflow folder.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ ! -d "$WORKFLOW_DIR" ]]; then
  echo "Workflow directory not found: $WORKFLOW_DIR"
  exit 1
fi

display_workflow_dir() {
  python3 - "$WORKFLOW_DIR" "$PWD" "${HOME:-}" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1]).resolve()
cwd = Path(sys.argv[2]).resolve()
home_arg = sys.argv[3]
home = Path(home_arg).resolve() if home_arg else None

try:
    print(path.relative_to(cwd))
    raise SystemExit
except ValueError:
    pass

if home is not None:
    try:
        rel = path.relative_to(home)
        print("~" if str(rel) == "." else f"~/{rel}")
        raise SystemExit
    except ValueError:
        pass

print(f"<outside-current-directory>/{path.name}")
PY
}

count_files() {
  local pattern="$1"
  find "$WORKFLOW_DIR" -type f -name "$pattern" 2>/dev/null | wc -l | tr -d ' '
}

required_status() {
  local path="$1"
  if [[ -f "$WORKFLOW_DIR/$path" ]]; then
    echo "- [x] \`$path\`"
  else
    echo "- [ ] \`$path\`"
  fi
}

workflow_display="$(display_workflow_dir)"
markdown_count="$(count_files '*.md')"
prompt_count=0
if [[ -d "$WORKFLOW_DIR/prompts" ]]; then
  prompt_count="$(find "$WORKFLOW_DIR/prompts" -type f -name 'pane-*.md' 2>/dev/null | wc -l | tr -d ' ')"
fi
handoff_status="missing"
if [[ -f "$WORKFLOW_DIR/handoff-summary.md" ]]; then
  handoff_status="present"
fi

cat <<EOF
# Workflow Status

- Workflow directory: \`$workflow_display\`
- Markdown file count: $markdown_count
- Pane prompt count: $prompt_count
- Handoff summary: $handoff_status

## Required files

$(required_status README.md)
$(required_status question.md)
$(required_status pane-roles.md)

## Markdown files
EOF

found=0
while IFS= read -r -d '' file; do
  rel="$(python3 - "$WORKFLOW_DIR" "$file" <<'PY'
from pathlib import Path
import sys
print(Path(sys.argv[2]).resolve().relative_to(Path(sys.argv[1]).resolve()))
PY
)"
  echo "- \`$rel\`"
  found=1
done < <(find "$WORKFLOW_DIR" -type f -name '*.md' -print0 | sort -z)

if [[ "$found" == "0" ]]; then
  echo "- No markdown files found."
fi

cat <<'EOF'

## Suggested next checks

- Fill empty sections before sharing.
- Run `./scripts/validate_workflow.sh <workflow-dir>` before export.
- Run `./scripts/close_workflow.sh <workflow-dir>` when panes have written notes.
EOF
