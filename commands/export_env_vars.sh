#!/bin/zsh

source $(dirname "$0")/current.sh

CURRENT_WORKSPACE_DIR=$(current_workspace_dir)
CURRENT_WORKSPACE_CONFIG_FILE=$(current_workspace_config_file)

# Check if the necessary environment variables are set
if [[ -z "$CURRENT_WORKSPACE_DIR" || -z "$CURRENT_WORKSPACE_CONFIG_FILE" ]]; then
    return 0
fi

# Check if the necessary files exist
if [[ ! -d "$CURRENT_WORKSPACE_DIR" ]]; then
    return 0
fi

if [[ ! -f "$CURRENT_WORKSPACE_CONFIG_FILE" ]]; then
    return 0
fi

# Function to export environment variables from the workspace configuration file
export_env_vars() {
    # Check if the env section exists in the configuration file
    if ! yq e '.env' $CURRENT_WORKSPACE_CONFIG_FILE > /dev/null 2>&1; then
        echo "Error: 'env' section not found in the configuration file."
        return 0
    fi

    local env_vars=$(yq e -r '.env[] | "\(.name)=\(.value)"' $CURRENT_WORKSPACE_CONFIG_FILE)
    for env_var in ${(f)env_vars}; do
        export $env_var
    done
}

# Call the function to export the environment variables
export_env_vars