#!/bin/zsh

FRAMEWORK_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)" && export FRAMEWORK_DIR
WORKSPACE_ROOT="$(dirname "$FRAMEWORK_DIR")" && export WORKSPACE_ROOT
CONFIG_FILE="$FRAMEWORK_DIR/config.yaml" && export CONFIG_FILE
COMMANDS_DIR="$FRAMEWORK_DIR/commands" && export COMMANDS_DIR

# Handle framework commands
case "$1" in
    change)
        "$COMMANDS_DIR/change.sh" "$2"  # Change the current workspace
        ;;
    cmd) # Execute a command from the current workspace
        source "$COMMANDS_DIR/cmd.sh" "${@:2}"
        do_cmd "$2" "${@:3}"
        ;;
    create)
        "$COMMANDS_DIR/create.sh" "$2"  # Create a new workspace
        ;;
    current) # Show the current workspace
        source "$COMMANDS_DIR/current.sh"
        do_current_workspace
        ;;
    drop)
        "$COMMANDS_DIR/drop.sh" "$2"  # Drop a workspace
        ;;
    help)
        "$COMMANDS_DIR/help.sh"  # Show help for commands
        ;;
    install)
        "$COMMANDS_DIR/install.sh"  # Install and configure the framework
        ;;
    list)
        "$COMMANDS_DIR/list.sh"  # List all workspaces
        ;;
    open)
        source "$COMMANDS_DIR/open.sh" "$2"  # Open a workspace
        ;;
    uninstall)
        "$COMMANDS_DIR/uninstall.sh"  # Uninstall and clean up the framework
        ;;
    *)
        echo "Unknown command. Type 'workspace help' for more information."
        exit 1
        ;;
esac
