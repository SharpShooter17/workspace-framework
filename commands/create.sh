#!/bin/zsh

# Check if the workspace name is provided
if [[ -z "$1" ]]; then
    echo "You must provide a workspace name!"
    exit 1
fi

WORKSPACE_NAME="$1"
WORKSPACE_DIR="$WORKSPACE_ROOT/$WORKSPACE_NAME"

# Check if the workspace already exists
if [[ -d "$WORKSPACE_DIR" ]]; then
    echo "Workspace '$WORKSPACE_NAME' already exists!"
    exit 1
fi

# Create the new workspace directory
mkdir "$WORKSPACE_DIR"
echo "Workspace '$WORKSPACE_NAME' has been created!"
