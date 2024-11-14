#!/bin/zsh

# Path to the .zshrc file
ZSHRC="$HOME/.zshrc"

# Add alias for the workspace command
echo "Adding alias 'workspace' to .zshrc file..."
echo "alias workspace='$(pwd)/workspace.sh'" >> "$ZSHRC"

# Add autocompletion for the workspace command
echo "Adding autocompletion for 'workspace'..."
cat << 'EOF' >> "$ZSHRC"

# Autocompletion for workspace command
_workspace_autocomplete() {
    local commands="add change list help"
    local cur_word=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$commands" -- "$cur_word") )
}
compdef _workspace_autocomplete workspace
EOF

# Refresh the shell configuration
echo "Installation complete. Refreshing shell..."
source "$ZSHRC"
echo "Framework has been successfully installed and configured."
