#!/bin/zsh

# Check if a workspace name is provided
if [[ -z "$1" ]]; then
    # Open the current workspace by default
    WORKSPACE_NAME=$(awk -F': ' '/^current_workspace:/ {print $2}' "$CONFIG_FILE")
else
    WORKSPACE_NAME="$1"
fi

WORKSPACE_DIR="$WORKSPACE_ROOT/$WORKSPACE_NAME"

# Open the workspace directory
if [[ -d "$WORKSPACE_DIR" ]]; then
    cd "$WORKSPACE_DIR"
    echo "Opened workspace: $WORKSPACE_NAME"
else
    echo "Workspace '$WORKSPACE_NAME' does not exist!"
    return 1
fi