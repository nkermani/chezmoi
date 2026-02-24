#!/bin/bash

for i in {1..9}; do
	gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done

SHORTCUTS=(
	"Kitty|/home/nkermani/.nkermani/bin/42/focus_kitty.sh|<Super>1"
	"Browser|/home/nkermani/.nkermani/bin/42/focus_browser.sh|<Super>2"
	"VSCode|/home/nkermani/.nkermani/bin/42/focus_vscode.sh|<Super>3"
	"Finder|/home/nkermani/.nkermani/bin/42/focus_finder.sh|<Super>4"
	"PDF|/home/nkermani/.nkermani/bin/42/focus_pdf.sh|<Super>5"
	"Discord|/home/nkermani/.nkermani/bin/42/focus_discord.sh|<Super>6"
	"GeForceNOW|/home/nkermani/.nkermani/bin/42/focus_geforcenow.sh|<Super>8"
)

gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>7', '<Super>9', '<Super>d']"

BASE="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
LIST="["
i=0
for entry in "${SHORTCUTS[@]}"; do
	IFS="|" read -r name cmd bind <<<"$entry"
	PATH_ID="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/"

	gsettings set "$BASE:$PATH_ID" name "$name"
	gsettings set "$BASE:$PATH_ID" command "$cmd"
	gsettings set "$BASE:$PATH_ID" binding "$bind"

	LIST+="'$PATH_ID',"
	((i++))
done

LIST="${LIST%,}]"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$LIST"
