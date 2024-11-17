#!/bin/zsh

source $(dirname "$0")/commands/list.sh

# Autocompletion for workspace command
_workspace() {
    local curcontext="$curcontext" state line
    typeset -A opt_args

    _arguments -C \
        '1: :->command' \
        '2: :->subcommand' \
        '*::arg:->args'

    case $state in
        command)
            local commands=(change cmd create current drop export_env_vars help install list open uninstall update)
            _describe -t commands 'workspace command' commands
            ;;
        subcommand)
            case $words[2] in
                change|drop|open)
                    local workspaces=($(workspaces_list))
                    _describe -t workspaces 'workspace' workspaces
                    ;;
                cmd)
                    local commands=()
                    if yq 'keys' $CURRENT_WORKSPACE_CONFIG_FILE | grep -q 'commands'; then
                        commands=($(yq --raw-output '.commands[].name' $CURRENT_WORKSPACE_CONFIG_FILE))
                    fi
                    if yq 'keys' $CURRENT_WORKSPACE_CONFIG_FILE | grep -q 'command_directories'; then
                        local command_directories=($(yq --raw-output '.command_directories[]' $CURRENT_WORKSPACE_CONFIG_FILE))
                        for dir in "${command_directories[@]}"; do
                            for script in "$CURRENT_WORKSPACE_DIR/$dir"/*.sh; do
                                commands+=("$(basename "$script" .sh)")
                            done
                        done
                    fi
                    _describe -t commands 'command' commands
                    ;;
            esac
            ;;
    esac
}

compdef _workspace workspace