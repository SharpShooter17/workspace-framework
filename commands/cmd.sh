#!/bin/zsh

source $(dirname "$0")/current.sh

do_cmd() {
    local script_name="$1"
    local workspace_name=$(current_workspace)
    local script_path="$WORKSPACE_ROOT/$workspace_name/commands/$script_name.sh"

    if [[ -f "$script_path" ]]; then
        "$script_path" "${@:2}"
    else
        echo "Script '$script_name' does not exist in the '$workspace_name' workspaces commands directory."
        return 1
    fi
}