#!/bin/bash
input="$1"
echo "DEBUG: $input" >> /tmp/kitty_debug.log

if [[ "$input" =~ File\ \"([^\"]+)\",\ line\ ([0-9]+) ]]; then
    path="${BASH_REMATCH[1]}"
    line="${BASH_REMATCH[2]}"
elif [[ "$input" =~ ([^\",:[:space:]]+):([0-9]+):([0-9]+) ]]; then
    path="${BASH_REMATCH[1]}"
    line="${BASH_REMATCH[2]}"
elif [[ "$input" =~ ([^\",:[:space:]]+):([0-9]+) ]]; then
    path="${BASH_REMATCH[1]}"
    line="${BASH_REMATCH[2]}"
else
    path="${input//\"/}"
    path="${path//,/}"
    line=""
fi

echo "DEBUG: path=$path line=$line" >> /tmp/kitty_debug.log

if [[ -n "$line" ]]; then
    kitty @ launch --type=overlay /Users/nkermani/.nkermani/bin/nvim "+$line" "$path"
else
    kitty @ launch --type=overlay /Users/nkermani/.nkermani/bin/nvim "$path"
fi
