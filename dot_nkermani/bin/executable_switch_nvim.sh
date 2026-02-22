#!/bin/bash

set -e

NVIM_CONFIGS=("full" "stock" "lazyvim" "nvchad")

echo "Available Neovim configs:"
echo ""
for i in "${!NVIM_CONFIGS[@]}"; do
	echo "  $((i + 1))) ${NVIM_CONFIGS[$i]}"
done
echo ""

read -p "Choose config to install [1-${#NVIM_CONFIGS[@]}]: " choice

if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#NVIM_CONFIGS[@]}" ]; then
	echo "Invalid choice"
	exit 1
fi

SELECTED="${NVIM_CONFIGS[$((choice - 1))]}"
CHEZMOI_DIR="$HOME/.local/share/chezmoi"
TARGET_DIR="$HOME/.config/nvim"
SOURCE_DIR="$CHEZMOI_DIR/dot_config/nvim_$SELECTED"

if [ ! -d "$SOURCE_DIR" ]; then
	echo "Error: $SOURCE_DIR does not exist"
	exit 1
fi

echo "Installing nvim_$SELECTED..."

if [ -L "$TARGET_DIR" ]; then
	rm "$TARGET_DIR"
elif [ -d "$TARGET_DIR" ]; then
	mv "$TARGET_DIR" "$TARGET_DIR.backup.$(date +%Y%m%d%H%M%S)"
fi

ln -s "$SOURCE_DIR" "$TARGET_DIR"

echo "Done! Run 'nvim' to use nvim_$SELECTED"
