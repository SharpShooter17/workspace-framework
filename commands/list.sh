#!/bin/zsh

source $(dirname "$0")/current.sh

CURRENT_WORKSPACE=$(current_workspace)

echo "Available workspaces:"
for WORKSPACE in "$WORKSPACE_ROOT"/*; do
    if [[ -d "$WORKSPACE" && "$WORKSPACE" != *"/workspace-framework"* ]]; then
        if [[ "$(basename "$WORKSPACE")" == "$CURRENT_WORKSPACE" ]]; then
            echo "> $(basename "$WORKSPACE") (Current Workspace)"
        else
            echo "$(basename "$WORKSPACE")"
        fi
    fi
done