#!/bin/zsh

# Path to the .zshrc file
ZSHRC="$HOME/.zshrc"

# Remove alias for the workspace command using awk
echo "Removing alias 'workspace' from .zshrc file..."
awk '!/alias workspace=/' "$ZSHRC" > ~/tmpfile && mv ~/tmpfile "$ZSHRC"

# Remove autocompletion for the workspace command using awk
echo "Removing autocompletion for 'workspace'..."
awk '/# Autocompletion for workspace command/{flag=1} flag && /compdef _workspace_autocomplete workspace/{flag=0; next} !flag' "$ZSHRC" > ~/tmpfile && mv ~/tmpfile "$ZSHRC"

# Refresh the shell configuration
echo "Uninstallation complete. Refreshing shell..."
source "$ZSHRC"
echo "Framework has been successfully uninstalled and cleaned up."