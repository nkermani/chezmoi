#!/bin/bash
# ------------------------------ #
#           nkermani             #
# ------------------------------ #

set -e

echo $'\033[1;31mVSCode is now available without user installation. `code` command is already in PATH and can be found in `/usr/bin/code`.\033[0m'
echo "Press any key to continue..."
read -srn 1

echo "Please, check if VSCode is not running. Press any key to continue..."
read -srn 1

archive="/tmp/vscode-$(date +"%Y%m%d%H%M%S").tar.gz"
download_url="https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
output="$HOME/.nkermani/apps/vscode"

echo "Downloading source archive..."
wget -q --show-progress -O $archive "$download_url"

mkdir -p $HOME/.apps
rm -rf "$output"
echo "Extracting to $output..."
mkdir "$output" && tar -xf "$archive" -C "$output" --strip-components 1 --checkpoint=.100
echo " Finished !"

ln -sf ~/.nkermani/apps/vscode/bin/code ~/.nkermani/bin/code


