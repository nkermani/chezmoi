#!/usr/bin/env bash
# Install Cyberpunk NK VS Code theme on Windows, WSL2, Linux, or macOS
# Usage: ./install-vscode-theme.sh [path-to-theme-json]

set -e

THEME_SRC="${1:-$(dirname "$0")/../cyberpunk-nk-color-theme.json}"
THEME_NAME="cyberpunk-nk-color-theme.json"
THEME_LABEL="Cyberpunk NK"

# Detect platform and set VS Code user directory
if grep -qi microsoft /proc/version 2>/dev/null; then
    # WSL2
    CODE_USER_DIR="/mnt/c/Users/$(cmd.exe /C "echo %USERNAME%" | tr -d '\r')/AppData/Roaming/Code/User"
    THEMES_DIR="$CODE_USER_DIR/themes"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    CODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    THEMES_DIR="$CODE_USER_DIR/themes"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    CODE_USER_DIR="$HOME/.config/Code/User"
    THEMES_DIR="$CODE_USER_DIR/themes"
elif [[ "$OS" == "Windows_NT" ]]; then
    # Windows (Git Bash, Cygwin, etc.)
    CODE_USER_DIR="/c/Users/$USERNAME/AppData/Roaming/Code/User"
    THEMES_DIR="$CODE_USER_DIR/themes"
else
    echo "Unsupported OS. Please copy the theme manually."
    exit 1
fi

mkdir -p "$THEMES_DIR"
cp "$THEME_SRC" "$THEMES_DIR/$THEME_NAME"
echo "Theme copied to $THEMES_DIR/$THEME_NAME"

# Optionally, update settings.json to use the theme (uncomment to enable)
# SETTINGS_JSON="$CODE_USER_DIR/settings.json"
# if [ -f "$SETTINGS_JSON" ]; then
#     if grep -q '"workbench.colorTheme"' "$SETTINGS_JSON"; then
#         sed -i.bak 's/"workbench.colorTheme"[^"]*"/"workbench.colorTheme": "$THEME_LABEL"/' "$SETTINGS_JSON"
#     else
#         sed -i.bak '1s/^/    \"workbench.colorTheme\": \"$THEME_LABEL\",\n/' "$SETTINGS_JSON"
#     fi
#     echo "Set workbench.colorTheme to $THEME_LABEL in settings.json"
# else
#     echo "settings.json not found, please set the theme manually in VS Code."
# fi

echo "Done! Now select '$THEME_LABEL' in VS Code's Color Theme picker."
