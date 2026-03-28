_get_viewer() {
	command -v bat >/dev/null 2>&1 && echo "bat --color=always --style=numbers" ||
		command -v batcat >/dev/null 2>&1 && echo "batcat --color=always --style=numbers" ||
		echo "cat"
}

f() {
	local dir
	if [[ "$1" == "-a" ]]; then
		dir=$(fd --type d --hidden --exclude .git --exclude .cache | fzf --prompt="📂 Go to (All): ")
	else
		dir=$(fd --type d --exclude .git --exclude .cache | fzf --prompt="📂 Go to: ")
	fi

	[[ -n "$dir" ]] && cd "$dir"
}

fr() {
	local dir
	if [[ "$1" == "-a" ]]; then
		dir=$(fd --type d --hidden . ~ | fzf --prompt="📂 Go to Home (All): ")
	else
		dir=$(fd --type d --exclude .git --exclude .cache . ~ | fzf --prompt="📂 Go to Home: ")
	fi

	[[ -n "$dir" ]] && cd "$dir"
}
