tell application "Terminal"
    activate
    set workbenchScript to system attribute "AGENT_WORKBENCH_SCRIPT"
    if workbenchScript is "" then
        set workbenchScript to (POSIX path of (path to home folder)) & "AgentWorkbench/local-agent-workbench/scripts/launch_codex_tmux.sh"
    end if
    do script "printf '\\033]0;Local Agent Workbench\\007'; AGENT_WORKBENCH_PANE_COUNT=9 " & quoted form of workbenchScript
    set bounds of front window to {40, 70, 1840, 1040}
end tell
