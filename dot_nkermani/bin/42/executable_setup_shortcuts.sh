#!/bin/bash

for i in {1..9}; do
    gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done

declare -A apps
apps["Kitty"]="/home/nkermani/.nkermani/bin/42/focus_kitty.sh:<Super>1"
apps["Browser"]="/home/nkermani/.nkermani/bin/42/focus_browser.sh:<Super>2"
apps["Finder"]="/home/nkermani/.nkermani/bin/42/focus_finder.sh:<Super>3"
apps["Discord"]="/home/nkermani/.nkermani/bin/42/focus_discord.sh:<Super>4"
apps["Desktop"]="/home/nkermani/.nkermani/bin/42/focus_desktop.sh:<Super>5"

BASE="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
LIST="["
i=0
for name in "Kitty" "Browser" "Finder" "Discord" "Desktop"; do
    val=${apps[$name]}
    cmd=${val%:*}
    bind=${val#*:}
    PATH_ID="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/"
    
    gsettings set "$BASE:$PATH_ID" name "$name"
    gsettings set "$BASE:$PATH_ID" command "$cmd"
    gsettings set "$BASE:$PATH_ID" binding "$bind"
    
    LIST+="'$PATH_ID',"
    ((i++))
done

LIST="${LIST%,}]"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$LIST"
