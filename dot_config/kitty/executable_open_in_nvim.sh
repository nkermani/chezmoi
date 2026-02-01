#!/bin/bash
input="$1"

if [[ "$input" =~ ^(.+):([0-9]+):([0-9]+) ]]; then
    file="${BASH_REMATCH[1]}"
    line="${BASH_REMATCH[2]}"
    col="${BASH_REMATCH[3]}"
    kitty @ launch --type=overlay /Users/nkermani/.nkermani/bin/nvim "+call cursor($line,$col)" "$file"
elif [[ "$input" =~ ^(.+):([0-9]+) ]]; then
    file="${BASH_REMATCH[1]}"
    line="${BASH_REMATCH[2]}"
    kitty @ launch --type=overlay /Users/nkermani/.nkermani/bin/nvim "+$line" "$file"
else
    kitty @ launch --type=overlay /Users/nkermani/.nkermani/bin/nvim "$input"
fi
