#!/bin/zsh

FRAMEWORK_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)" && export FRAMEWORK_DIR
WORKSPACE_ROOT="$(dirname "$FRAMEWORK_DIR")" && export WORKSPACE_ROOT
CONFIG_FILE="$FRAMEWORK_DIR/config.yaml" && export CONFIG_FILE
COMMANDS_DIR="$FRAMEWORK_DIR/commands" && export COMMANDS_DIR

# Handle framework commands
case "$1" in
    change)
        "$COMMANDS_DIR/change.sh" "$2" || { return 1; }
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
    help)
        "$COMMANDS_DIR/help.sh" || { return 1; }
        ;;
    install)
        "$COMMANDS_DIR/install.sh" || { return 1; }
        ;;
    list)
        "$COMMANDS_DIR/list.sh" || { return 1; }
        ;;
    open)
        source "$COMMANDS_DIR/open.sh" "$2" || { return 1; }
        ;;
    uninstall)
        "$COMMANDS_DIR/uninstall.sh" || { return 1; }
        ;;
    *)
        echo "Unknown command. Type 'workspace help' for more information." >&2
        ;;
esac