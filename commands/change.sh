#!/bin/zsh

# Check if the workspace name is provided
if [[ -z "$1" ]]; then
    echo "You must provide a workspace name!"
    return 1
 1
fi

WORKSPACE_NAME="$1"
WORKSPACE_DIR="$WORKSPACE_ROOT/$WORKSPACE_NAME"

# Check if the workspace exists
if [[ ! -d "$WORKSPACE_DIR" ]]; then
    echo "Workspace '$WORKSPACE_NAME' does not exist!"
    return 1
fi

# Update the config file with the new workspace
if [ -f "$CONFIG_FILE" ]; then
    awk -v new_workspace="$WORKSPACE_NAME" '/^current_workspace:/ {$2=new_workspace} 1' "$CONFIG_FILE" > ~/tmpfile && mv ~/tmpfile "$CONFIG_FILE"
    echo "Switched to workspace '$WORKSPACE_NAME'"
else
    echo "Config file not found."
    return 1
fi