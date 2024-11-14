#!/bin/zsh

FRAMEWORK_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)" && export FRAMEWORK_DIR
WORKSPACE_ROOT="$(dirname "$FRAMEWORK_DIR")" && export WORKSPACE_ROOT
CONFIG_FILE="$FRAMEWORK_DIR/config.yaml" && export CONFIG_FILE
COMMANDS_DIR="$FRAMEWORK_DIR/commands"

# Handle framework commands
case "$1" in
    create)
        "$COMMANDS_DIR/create.sh" "$2"  # Create a new workspace
        ;;
    current)
        "$COMMANDS_DIR/current.sh"  # Show the current workspace
        ;;
    change)
        "$COMMANDS_DIR/change.sh" "$2"  # Change the current workspace
        ;;
    drop)
        "$COMMANDS_DIR/drop.sh" "$2"  # Drop a workspace
        ;;
    list)
        "$COMMANDS_DIR/list.sh"  # List all workspaces
        ;;
    install)
        "$COMMANDS_DIR/install.sh"  # Install and configure the framework
        ;;
    help)
        "$COMMANDS_DIR/help.sh"  # Show help for commands
        ;;
    *)
        echo "Unknown command. Type 'workspace help' for more information."
        exit 1
        ;;
esac
