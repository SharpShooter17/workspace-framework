#!/bin/zsh

FRAMEWORK_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)" && export FRAMEWORK_DIR
WORKSPACE_ROOT="$(dirname "$FRAMEWORK_DIR")" && export WORKSPACE_ROOT
CONFIG_FILE="$WORKSPACE_ROOT/workspace.yml" && export CONFIG_FILE
COMMANDS_DIR="$FRAMEWORK_DIR/commands" && export COMMANDS_DIR

# Handle framework commands
case "$1" in
    change)
        source "$COMMANDS_DIR/change.sh" "$2" || { return 1; }
        ;;
    cmd)
        source "$COMMANDS_DIR/cmd.sh"
        do_cmd "$2" "${@:3}" || { return 1; }
        ;;
    create)
        "$COMMANDS_DIR/create.sh" "$2" || { return 1; }
        ;;
    current)
        source "$COMMANDS_DIR/current.sh"
        do_current_workspace || { return 1; }
        ;;
    drop)
        "$COMMANDS_DIR/drop.sh" "$2" || { return 1; }
        ;;
    export_env_vars)
        source "$COMMANDS_DIR/export_env_vars.sh" || { return 1; }
        ;;
    help)
        "$COMMANDS_DIR/help.sh" || { return 1; }
        ;;
    list)
        source "$COMMANDS_DIR/list.sh"
        do_list || { return 1; }
        ;;
    open)
        source "$COMMANDS_DIR/open.sh" "$2" || { return 1; }
        ;;
    update)
        source "$COMMANDS_DIR/update.sh"
        do_update || { return 1; }
        ;;
    *)
        echo "Unknown command. Type 'workspace help' for more information." >&2
        ;;
esac