#!/bin/zsh

# Path to the .zshrc file
ZSHRC="$HOME/.zshrc"
WORKSPACE_SCRIPT="$FRAMEWORK_DIR/workspace.sh"
WORKSPACE_YML="$WORKSPACE_ROOT/workspace.yml"
AUTOCOMPLETE_SCRIPT="$FRAMEWORK_DIR/autocomplete.sh"

# Check if the workspace function is already installed
if ! grep -q "workspace() {" "$ZSHRC"; then
  echo "Adding function 'workspace' to .zshrc file..."
  TMPFILE=$(mktemp)
  cp "$ZSHRC" "$TMPFILE"
  cat << EOF >> "$TMPFILE"
workspace() {
  source "$WORKSPACE_SCRIPT" "\$@"
}
EOF
  mv "$TMPFILE" "$ZSHRC"
  echo "Function 'workspace' added successfully."
else
  echo "Function 'workspace' is already installed in .zshrc file."
fi

# Check if the autocompletion for the workspace command is already installed
if ! grep -q "source $AUTOCOMPLETE_SCRIPT" "$ZSHRC"; then
  echo "Adding autocompletion for 'workspace'..."
  TMPFILE=$(mktemp)
  cp "$ZSHRC" "$TMPFILE"
  echo "source $AUTOCOMPLETE_SCRIPT" >> "$TMPFILE"
  mv "$TMPFILE" "$ZSHRC"
  echo "Autocompletion for 'workspace' added successfully."
else
  echo "Autocompletion for 'workspace' is already installed in .zshrc file."
fi

# Invoke workspace export_env_vars
if ! grep -q "workspace export_env_vars" "$ZSHRC"; then
  echo "Adding invocation of workspace export_env_vars to .zshrc file..."
  TMPFILE=$(mktemp)
  cp "$ZSHRC" "$TMPFILE"
  echo "workspace export_env_vars" >> "$TMPFILE"
  mv "$TMPFILE" "$ZSHRC"
  echo "Invocation of workspace export_env_vars added successfully."
else
  echo "Invocation of workspace export_env_vars is already in .zshrc file."
fi

# Create workspace.yml file in WORKSPACE_ROOT directory
if [ ! -f "$WORKSPACE_YML" ]; then
  echo "Creating workspace.yml file in $WORKSPACE_ROOT..."
  cat << EOF > "$WORKSPACE_YML"
config:
  current_workspace: default
EOF
  if [ $? -eq 0 ]; then
    echo "workspace.yml file created successfully."
  else
    echo "Error creating workspace.yml file." >&2
    return 1
  fi
else
  echo "workspace.yml file already exists in $WORKSPACE_ROOT."
fi

# Refresh the shell configuration
echo "Installation complete. Refreshing shell..."
source "$ZSHRC"
echo "Framework has been successfully installed and configured."