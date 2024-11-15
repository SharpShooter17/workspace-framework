#!/bin/zsh

current_workspace() {
    if [[ -f "$CONFIG_FILE" ]]; then
        grep 'current_workspace' "$CONFIG_FILE" | awk '{print $2}' | tr -d '"'
    else
        echo "Config file not found." >&2
        return 1
    fi
}

do_current_workspace() {
    local workspace_name=$(current_workspace)

    if [[ $? -eq 0 && -n "$workspace_name" ]]; then
        echo "Current workspace: $workspace_name"
    else
        echo "No current workspace set or an error occurred." >&2
    fi
}