#!/bin/zsh

source $(dirname "$0")/current.sh

# Check if a workspace name is provided
if [[ -z "$1" ]]; then
    echo "You must provide a workspace name!" >&2
    exit 1
fi

WORKSPACE_NAME="$1"
WORKSPACE_DIR="$WORKSPACE_ROOT/$WORKSPACE_NAME"

# Check if the workspace exists
if [[ ! -d "$WORKSPACE_DIR" ]]; then
    echo "Workspace '$WORKSPACE_NAME' does not exist!" >&2
    exit 1
fi

# Check if the config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Config file not found." >&2
    exit 1
fi

# Check if the workspace to drop is the current workspace
if [[ "$WORKSPACE_NAME" == "$(current_workspace)" ]]; then
    echo "Cannot drop the current workspace. Switch to a different workspace first." >&2
    exit 1
fi

# Drop the workspace from the config file
TMPFILE=$(mktemp)
awk -v workspace="$WORKSPACE_NAME" '$2 != workspace' "$CONFIG_FILE" > "$TMPFILE" && mv "$TMPFILE" "$CONFIG_FILE"
echo "Dropped workspace '$WORKSPACE_NAME' from the configuration file."

# Remove the workspace directory
rm -rf "$WORKSPACE_DIR"
echo "Removed workspace directory '$WORKSPACE_DIR'."