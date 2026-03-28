#!/bin/bash
# Script to mount a remote directory using sshfs for Neovim
# check
# Check if sshfs is installed
if ! command -v sshfs &> /dev/null; then
    echo "Error: sshfs is not installed."
    echo "Please install it first:"
    echo "  MacOS: brew install macfuse && brew install sshfs"
    echo "  Linux: sudo apt install sshfs (or equivalent)"
    exit 1
fi

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <user@host:/remote/path> <local_mount_path>"
    echo "Example: $0 user@192.168.1.50:/home/user/project ./mnt"
    exit 1
fi

REMOTE=$1
MOUNT_POINT=$2

# Create mount point if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
    mkdir -p "$MOUNT_POINT"
fi

echo "Mounting $REMOTE to $MOUNT_POINT..."
sshfs "$REMOTE" "$MOUNT_POINT" -o volname=$(basename "$MOUNT_POINT")

if [ $? -eq 0 ]; then
    echo "Successfully mounted!"
    echo "Opening Neovim in $MOUNT_POINT..."
    cd "$MOUNT_POINT" && nvim .
else
    echo "Failed to mount."
    exit 1
fi

