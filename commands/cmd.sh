#!/bin/zsh

source $(dirname "$0")/current.sh

CURRENT_WORKSPACE_DIR=$(current_workspace_dir)
CURRENT_WORKSPACE_CONFIG_FILE=$(current_workspace_config_file)

find_command_script() {
    local command_name="$1"
    local command_script=$(yq e -r ".commands[] | select(.name == \"$command_name\") | .script" $CURRENT_WORKSPACE_CONFIG_FILE)

    if [[ -z "$command_script" ]]; then
        local command_directories=($(yq e -r '.command_directories[]' $CURRENT_WORKSPACE_CONFIG_FILE))
        for dir in $command_directories; do
            if [[ -f "$CURRENT_WORKSPACE_DIR/$dir/$command_name.sh" ]]; then
                command_script="$dir/$command_name.sh"
                break
            fi
        done
    fi

    echo "$command_script"
}

do_cmd() {
    local command_name="$1"
    local workspace_name=$(current_workspace)
    local command_script=$(find_command_script $command_name)

    if [[ -z "$command_script" ]]; then
        echo "Command '$command_name' not found in the '$workspace_name' workspace configuration."
        return 1
    fi

    local script_path="$CURRENT_WORKSPACE_DIR/$command_script"

    if [[ -f "$script_path" ]]; then
        (cd "$(dirname "$script_path")" && "./$(basename "$script_path")" "${@:2}")
    else
        echo "Script '$script_path' does not exist in the '$workspace_name' workspace."
        return 1
    fi
}