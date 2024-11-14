#!/bin/zsh

# Get the current workspace from the config file
CURRENT_WORKSPACE=$(awk -F': ' '/^current_workspace:/ {print $2}' "$CONFIG_FILE")

# List available workspaces (directories) in the parent directory of the workspace-framework directory
echo "Available workspaces:"
for WORKSPACE in "$WORKSPACE_ROOT"/*; do
    if [[ -d "$WORKSPACE" && "$WORKSPACE" != *"/workspace-framework"* ]]; then  # Exclude the workspace-framework directory itself
        # Check if the current workspace
        if [[ "$(basename "$WORKSPACE")" == "$CURRENT_WORKSPACE" ]]; then
            echo "> $(basename "$WORKSPACE") (Current Workspace)"
        else
            echo "$(basename "$WORKSPACE")"
        fi
    fi
done