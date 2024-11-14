#!/bin/zsh

# Check if a workspace name is provided
if [[ -z "$1" ]]; then
    echo "You must provide a workspace name!"
    exit 1
fi

WORKSPACE_NAME="$1"
WORKSPACE_DIR="$WORKSPACE_ROOT/$WORKSPACE_NAME"

# Check if the workspace exists
if [[ ! -d "$WORKSPACE_DIR" ]]; then
    echo "Workspace '$WORKSPACE_NAME' does not exist!"
    exit 1
fi

# Check if the config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Config file not found."
    exit 1
fi

# Check if the workspace to drop is the current workspace
CURRENT_WORKSPACE=$(awk -F': ' '/^current_workspace:/ {print $2}' "$CONFIG_FILE")
if [[ "$WORKSPACE_NAME" == "$CURRENT_WORKSPACE" ]]; then
    echo "Cannot drop the current workspace. Switch to a different workspace first."
    exit 1
fi

# Drop the workspace from the config file
awk -v workspace="$WORKSPACE_NAME" '$2 != workspace' "$CONFIG_FILE" > ~/tmpfile && mv ~/tmpfile "$CONFIG_FILE"
echo "Dropped workspace '$WORKSPACE_NAME' from the configuration file."

# Remove the workspace directory
rm -rf "$WORKSPACE_DIR"
echo "Removed workspace directory '$WORKSPACE_DIR'."