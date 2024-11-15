#!/bin/zsh

FRAMEWORK_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)" && export FRAMEWORK_DIR
WORKSPACE_ROOT="$(dirname "$FRAMEWORK_DIR")" && export WORKSPACE_ROOT
CONFIG_FILE="$FRAMEWORK_DIR/config.yaml" && export CONFIG_FILE
COMMANDS_DIR="$FRAMEWORK_DIR/commands" && export COMMANDS_DIR

# Handle framework commands
case "$1" in
    change)
        "$COMMANDS_DIR/change.sh" "$2" || { echo "Error executing change command" >&2; return 1; }
        ;;
    cmd)
        source "$COMMANDS_DIR/cmd.sh" "${@:2}" || { echo "Error executing cmd command" >&2; return 1; }
        do_cmd "$2" "${@:3}" || { echo "Error executing do_cmd function" >&2; return 1; }
        ;;
    create)
        "$COMMANDS_DIR/create.sh" "$2" || { echo "Error executing create command" >&2; return 1; }
        ;;
    current)
        source "$COMMANDS_DIR/current.sh" || { echo "Error sourcing current.sh" >&2; return 1; }
        do_current_workspace || { echo "Error executing do_current_workspace function" >&2; return 1; }
        ;;
    drop)
        "$COMMANDS_DIR/drop.sh" "$2" || { echo "Error executing drop command" >&2; return 1; }
        ;;
    help)
        "$COMMANDS_DIR/help.sh" || { echo "Error executing help command" >&2; return 1; }
        ;;
    install)
        "$COMMANDS_DIR/install.sh" || { echo "Error executing install command" >&2; return 1; }
        ;;
    list)
        "$COMMANDS_DIR/list.sh" || { echo "Error executing list command" >&2; return 1; }
        ;;
    open)
        source "$COMMANDS_DIR/open.sh" "$2" || { echo "Error sourcing open.sh" >&2; return 1; }
        ;;
    uninstall)
        "$COMMANDS_DIR/uninstall.sh" || { echo "Error executing uninstall command" >&2; return 1; }
        ;;
    *)
        echo "Unknown command. Type 'workspace help' for more information." >&2
        ;;
esac