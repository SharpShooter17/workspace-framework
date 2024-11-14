#!/bin/zsh

# Path to the .zshrc file
ZSHRC="$HOME/.zshrc"

# Remove function for the workspace command using awk
echo "Removing function 'workspace' from .zshrc file..."
awk '/workspace\(\) {/,/}/ {next} {print}' "$ZSHRC" > ~/tmpfile && mv ~/tmpfile "$ZSHRC"

# Remove autocompletion for the workspace command using awk
echo "Removing autocompletion for 'workspace'..."
awk '/# Autocompletion for workspace command/,/compdef _workspace_autocomplete workspace/ {next} {print}' "$ZSHRC" > ~/tmpfile && mv ~/tmpfile "$ZSHRC"

# Refresh the shell configuration
echo "Uninstallation complete. Refreshing shell..."
source "$ZSHRC"