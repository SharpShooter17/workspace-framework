#!/bin/zsh

# Function to display the help information for each command
help_command() {
    echo "Workspace Framework - Help"
    echo "Available commands:"
    echo ""
    echo "  change <workspace-name>  Change to a different workspace"
    echo "  create <workspace-name>  Create a new workspace"
    echo "  current                  Show the current workspace"
    echo "  drop <workspace-name>    [WARNING] Drop a workspace from the configuration file and delete the workspace directory"
    echo "  help                     Display this help message"
    echo "  install                  Install and configure the framework"
    echo "  list                     List all available workspaces"
    echo "  open [workspace-name]    Open a workspace"
    echo "  uninstall                Uninstall the framework"
    echo ""
    echo "Each command can be used as follows:"
    echo "  workspace <command> [args]"
    echo ""
    echo "For more detailed help on any command, type:"
    echo "  workspace <command> help"
    echo ""
}

# Call the help function to display the information
help_command