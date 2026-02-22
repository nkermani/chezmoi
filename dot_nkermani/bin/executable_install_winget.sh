#!/bin/bash
set -e

echo "Ensuring winget is installed on Windows..."

if /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command "Get-AppInstaller" &>/dev/null; then
	echo "winget already available"
	exit 0
fi

if /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command "winget --version" &>/dev/null; then
	echo "winget is now available"
	exit 0
fi

echo "winget not found. Install from Microsoft Store:"
echo "https://apps.microsoft.com/store/detail/windows-app-installer/9NBLGGH4LNS8"
exit 1
