#!/bin/zsh

# Define the path to the config file
CONFIG_FILE="$FRAMEWORK_DIR/config.yaml"

# Function to show the current workspace
current_workspace() {
    # Check if the config file exists
    if [[ -f "$CONFIG_FILE" ]]; then
        # Use grep to extract the current workspace from the config file
        CURRENT_WORKSPACE=$(grep 'current_workspace' "$CONFIG_FILE" | awk '{print $2}' | tr -d '"')

        if [[ -n "$CURRENT_WORKSPACE" ]]; then
            echo "Current workspace: $CURRENT_WORKSPACE"
        else
            echo "No current workspace set."
        fi
    else
        echo "Config file not found."
    fi
}

# Execute the current workspace function
current_workspace