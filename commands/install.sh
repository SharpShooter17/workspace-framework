#!/bin/zsh

# Path to the .zshrc file
ZSHRC="$HOME/.zshrc"

# Check if the workspace function is already installed
if ! grep -q "workspace() {" "$ZSHRC"; then
  # Add function for the workspace command
  echo "Adding function 'workspace' to .zshrc file..."
  cat << 'EOF' >> "$ZSHRC"
workspace() {
  source /mnt/c/WORKSPACE/workspace-framework/workspace.sh "$@"
}
EOF
else
  echo "Function 'workspace' is already installed in .zshrc file."
fi

# Check if the autocompletion for the workspace command is already installed
if ! grep -q "_workspace" "$ZSHRC"; then
  COMMAND_LIST=$(ls "$COMMANDS_DIR" | awk -F'.sh' '{print $1}' | tr '\n' ' ')

  TEXT_TO_ADD="
# Autocompletion for workspace command
_workspace() {
    compadd $COMMAND_LIST
}
compdef _workspace workspace
"

  echo "Adding autocompletion for 'workspace'..."
  echo "$TEXT_TO_ADD" >> "$ZSHRC"
else
  echo "Autocompletion for 'workspace' is already installed in .zshrc file."
fi

# Refresh the shell configuration
echo "Installation complete. Refreshing shell..."
source "$ZSHRC"
echo "Framework has been successfully installed and configured."