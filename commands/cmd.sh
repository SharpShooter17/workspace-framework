#!/bin/zsh

source $(dirname "$0")/current.sh

CURRENT_WORKSPACE_DIR=$(current_workspace_dir)
CURRENT_WORKSPACE_CONFIG_FILE=$(current_workspace_config_file)

do_cmd() {
    local command_name="$1"
    local workspace_name=$(current_workspace)
    local command_script=$(yq --raw-output ".commands[] | select(.name == \"$command_name\") | .script" $CURRENT_WORKSPACE_CONFIG_FILE)

    if [[ -z "$command_script" ]]; then
        echo "Command '$command_name' not found in the '$workspace_name' workspace configuration."
        return 1
    fi

    local script_path="$CURRENT_WORKSPACE_DIR/$command_script"

    if [[ -f "$script_path" ]]; then
        "$script_path" "${@:2}"
    else
        echo "Script '$script_path' does not exist in the '$workspace_name' workspace."
        return 1
    fi
}