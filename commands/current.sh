#!/bin/zsh

current_workspace() {
  yq e '.config.current_workspace' "$CONFIG_FILE" | tr -d '"'
}

current_workspace_dir() {
  echo "$WORKSPACE_ROOT/$(current_workspace)"
}

current_workspace_config_file() {
  echo "$(current_workspace_dir)/workspace.yml"
}

do_current_workspace() {
    local workspace_name=$(current_workspace)

    if [[ $? -eq 0 && -n "$workspace_name" ]]; then
        echo "Current workspace: $workspace_name"
    else
        echo "No current workspace set or an error occurred." >&2
        return 1
    fi
}