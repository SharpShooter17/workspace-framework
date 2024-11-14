#!/bin/zsh

# Function to execute scripts from the current workspace's commands directory
cmd() {
    local script_name="$1"
    local workspace_name=$(awk -F': ' '/^current_workspace:/ {print $2}' "$CONFIG_FILE")
    local script_path="$WORKSPACE_ROOT/$workspace_name/commands/$script_name"

    if [[ -f "$script_path" ]]; then
        zsh "$script_path" "${@:2}"
    else
        echo "Script '$script_name' does not exist in the '$workspace_name' workspace's commands directory."
        return 1
    fi
}

# Execute the cmd function with the provided arguments
cmd "$@"