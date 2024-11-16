#!/bin/zsh

# Path to the .zshrc file
ZSHRC="$HOME/.zshrc"
BACKUP_ZSHRC="$HOME/.zshrc.bak"
WORKSPACE_YML="$WORKSPACE_ROOT/workspace.yml"

# Create a backup of the .zshrc file
echo "Creating a backup of the .zshrc file..."
cp "$ZSHRC" "$BACKUP_ZSHRC"

# Remove function for the workspace command using awk
echo "Removing function 'workspace' from .zshrc file..."
TMPFILE=$(mktemp)
if awk '/workspace\(\) {/,/}/ {next} {print}' "$ZSHRC" > "$TMPFILE"; then
    mv "$TMPFILE" "$ZSHRC"
else
    echo "Error removing function 'workspace' from .zshrc file." >&2
    return 1
fi

# Remove autocompletion for the workspace command using awk
echo "Removing autocompletion for 'workspace'..."
TMPFILE=$(mktemp)
if awk '/# Autocompletion for workspace command/,/compdef _workspace workspace/ {next} {print}' "$ZSHRC" > "$TMPFILE"; then
    mv "$TMPFILE" "$ZSHRC"
else
    echo "Error removing autocompletion for 'workspace'." >&2
    return 1
fi

# Remove workspace.yml file
if [ -f "$WORKSPACE_YML" ]; then
    echo "Removing workspace.yml file..."
    rm "$WORKSPACE_YML"
    if [ $? -eq 0 ]; then
        echo "workspace.yml file removed successfully."
    else
        echo "Error removing workspace.yml file." >&2
        return 1
    fi
else
    echo "workspace.yml file does not exist."
fi

# Refresh the shell configuration
echo "Uninstallation complete. Refreshing shell..."
source "$ZSHRC"