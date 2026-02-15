#!/bin/bash

OS_TYPE=$(uname -s)
NK_DIR="$HOME/.nkermani"
APPS_DIR="$NK_DIR/apps"
BIN_DIR="$NK_DIR/bin"
CHEZMOI_SOURCE="$HOME/.local/share/chezmoi"

echo "Starting deep cleanup of unwanted tools..."

# Helper: Remove file or directory if it exists
safe_rm() {
    local path=$1
    if [ -e "$path" ] || [ -L "$path" ]; then
        echo "  Removing: $path"
        rm -rf "$path"
    fi
}

# Helper: Remove tool from personal bin/apps
remove_tool() {
    local name=$1
    safe_rm "$BIN_DIR/$name"
    safe_rm "$APPS_DIR/$name"
}

# 1. Zellij
echo "Cleaning up Zellij..."
remove_tool "zellij"
safe_rm "$HOME/.config/zellij"
safe_rm "$CHEZMOI_SOURCE/dot_config/zellij"

# 2. Kitty
echo "Cleaning up Kitty..."
remove_tool "kitty"
if [[ "$OS_TYPE" == "Darwin" ]]; then
    if command -v brew &>/dev/null; then
        brew uninstall --cask kitty 2>/dev/null
    fi
else
    safe_rm "$APPS_DIR/kitty.app"
fi
safe_rm "$HOME/.config/kitty"
safe_rm "$CHEZMOI_SOURCE/dot_config/kitty"

# 3. WezTerm
echo "Cleaning up WezTerm..."
if [[ "$OS_TYPE" == "Darwin" ]]; then
    if command -v brew &>/dev/null; then
        brew uninstall --cask wezterm 2>/dev/null
    fi
fi
safe_rm "$HOME/.config/wezterm"
safe_rm "$HOME/.wezterm.lua"
safe_rm "$CHEZMOI_SOURCE/dot_config/wezterm"

# 4. Old Vim
echo "Cleaning up old Vim config..."
safe_rm "$HOME/.vimrc"
safe_rm "$HOME/.vim"
safe_rm "$CHEZMOI_SOURCE/dot_vimrc"

# 5. Zed
echo "Cleaning up Zed..."
remove_tool "zed"
remove_tool "zed-editor"
if [[ "$OS_TYPE" == "Darwin" ]]; then
    if command -v brew &>/dev/null; then
        brew uninstall --cask zed 2>/dev/null
    fi
fi
safe_rm "$HOME/.config/zed"

echo "Cleanup complete! Only Neovim and core tools remain."
echo "Don't forget to run 'chezmoi apply' to sync the state."
