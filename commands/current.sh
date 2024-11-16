#!/bin/zsh

current_workspace() {
  yq '.config.current_workspace' "$CONFIG_FILE" | tr -d '"'
}

do_current_workspace() {
    local workspace_name=$(current_workspace)

    if [[ $? -eq 0 && -n "$workspace_name" ]]; then
        echo "Current workspace: $workspace_name"
    else
        echo "No current workspace set or an error occurred." >&2
        return 1
    fi
}