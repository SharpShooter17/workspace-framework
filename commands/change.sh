#!/bin/zsh

# Check if the workspace name is provided
if [[ -z "$1" ]]; then
    echo "You must provide a workspace name!"
    return 1
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
    yq ".config.current_workspace = \"$WORKSPACE_NAME\"" "$CONFIG_FILE" -y >> "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
    if [[ $? -eq 0 ]]; then
        echo "Switched to workspace '$WORKSPACE_NAME'"
    else
        echo "Failed to update the config file."
        return 1
    fi
else
    echo "Config file not found."
    return 1
fi