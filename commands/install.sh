#!/bin/zsh

# Path to the .zshrc file
ZSHRC="$HOME/.zshrc"
WORKSPACE_SCRIPT="$FRAMEWORK_DIR/workspace.sh"

# Check if the workspace function is already installed
if ! grep -q "workspace() {" "$ZSHRC"; then
  # Add function for the workspace command
  echo "Adding function 'workspace' to .zshrc file..."
  if cat << EOF >> "$ZSHRC"
workspace() {
  source "$WORKSPACE_SCRIPT" "\$@"
}
EOF
  then
    echo "Function 'workspace' added successfully."
  else
    echo "Error adding function 'workspace' to .zshrc file." >&2
    exit 1
  fi
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
  if echo "$TEXT_TO_ADD" >> "$ZSHRC"; then
    echo "Autocompletion for 'workspace' added successfully."
  else
    echo "Error adding autocompletion for 'workspace'." >&2
    exit 1
  fi
else
  echo "Autocompletion for 'workspace' is already installed in .zshrc file."
fi

# Refresh the shell configuration
echo "Installation complete. Refreshing shell..."
source "$ZSHRC"
echo "Framework has been successfully installed and configured."