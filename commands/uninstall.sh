#!/bin/zsh

# Path to the .zshrc file
ZSHRC="$HOME/.zshrc"
BACKUP_ZSHRC="$HOME/.zshrc.bak"

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
    exit 1
fi

# Remove autocompletion for the workspace command using awk
echo "Removing autocompletion for 'workspace'..."
TMPFILE=$(mktemp)
if awk '/# Autocompletion for workspace command/,/compdef _workspace workspace/ {next} {print}' "$ZSHRC" > "$TMPFILE"; then
    mv "$TMPFILE" "$ZSHRC"
else
    echo "Error removing autocompletion for 'workspace'." >&2
    exit 1
fi

# Refresh the shell configuration
echo "Uninstallation complete. Refreshing shell..."
source "$ZSHRC"