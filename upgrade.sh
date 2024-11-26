#!/bin/zsh

# Define the necessary files and directories
FILES_TO_CHMOD=(
    "workspace.sh"
    "install.sh"
    "uninstall.sh"
    "upgrade.sh"
    "commands/*.sh"
)

# Function to reset and pull the latest changes from Git
update_git_repo() {
    git reset --hard HEAD
    git pull origin master
}

# Function to add execution permissions to the necessary files
add_execution_permissions() {
    for file in $FILES_TO_CHMOD; do
        chmod +x $file
    done
}

# Main script execution
update_git_repo
add_execution_permissions

echo "Upgrade completed successfully."