#!/bin/zsh

source $(dirname "$0")/current.sh

workspaces_list() {
    local workspaces=()
    for workspace in "$WORKSPACE_ROOT"/*; do
        if [[ -d "$workspace" && "$workspace" != *"/workspace-framework"* ]]; then
            workspaces+=("$(basename "$workspace")")
        fi
    done
    echo "${workspaces[@]}"
}

list() {
    local current_workspace=$(current_workspace)
    local workspaces=($(workspaces_list))
    for workspace in "${workspaces[@]}"; do
        if [[ "$workspace" == "$current_workspace" ]]; then
            echo "> $workspace (Current Workspace)"
        else
            echo "$workspace"
        fi
    done
}

do_list() {
    echo "Available workspaces:"
    list
}