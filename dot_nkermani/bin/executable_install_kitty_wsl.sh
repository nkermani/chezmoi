#!/bin/bash
set -e

echo "Installing WezTerm on Windows..."

PS="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"

if [ -f "/mnt/c/Program Files/WezTerm/wezterm.exe" ]; then
	echo "WezTerm already installed!"
	exit 0
fi

if $PS -Command "winget --version" &>/dev/null; then
	$PS -Command "winget install --id Wez.wezterm --silent --accept-package-agreements --accept-source-agreements"
fi

if [ -f "/mnt/c/Program Files/WezTerm/wezterm.exe" ]; then
	echo "WezTerm installed successfully!"
else
	echo "Failed. Try manually: winget install wezterm"
fi
