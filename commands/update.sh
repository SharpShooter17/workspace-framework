#!/bin/zsh

source "$COMMANDS_DIR/current.sh"

CURRENT_WORKSPACE_DIR=$(current_workspace_dir)
CURRENT_WORKSPACE_CONFIG_FILE=$(current_workspace_config_file)

update_repositories() {
    local repos=($(yq --raw-output '.repositories[]' $CURRENT_WORKSPACE_CONFIG_FILE))

    for repo in $repos; do
        local repo_name=$(echo $repo | gawk -F'[:/.]' '{print $(NF-1)}')
        local repo_dir="$CURRENT_WORKSPACE_DIR/$repo_name"

        if [[ -d "$repo_dir/.git" ]]; then
            echo "Updating repository $repo..."
            git -C $repo_dir pull
        else
            echo "Cloning repository $repo"
            git clone $repo $repo_dir
        fi

        if [[ $? -ne 0 ]]; then
            echo "Failed to update/clone repository $repo_name." >&2
        fi
    done
}

do_update() {
    if [[ ! -f "$CURRENT_WORKSPACE_CONFIG_FILE" ]]; then
        echo "Config file not found." >&2
        return 1
    fi

    if [[ ! -d "$CURRENT_WORKSPACE_DIR" ]]; then
        echo "Workspace directory not found." >&2
        return 1
    fi

    update_repositories
}