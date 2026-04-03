# ~/.bashrc.d/30-functions.sh

_get_viewer() {
	command -v bat >/dev/null 2>&1 && echo "bat --color=always --style=numbers" ||
		command -v batcat >/dev/null 2>&1 && echo "batcat --color=always --style=numbers" ||
		echo "cat"
}

f() {
	local dir
	if [[ "$1" == "-a" ]]; then
		dir=$(fd --type d --hidden --exclude .git --exclude .cache | fzf --prompt="📂 Go to (All): ")
	elif [[ "$1" == "-t" ]]; then
		dir=$(fd --type d --hidden --exclude .git --exclude .cache . | fzf --prompt="📂 Go to (Tree): " --height=40% --layout=reverse-list)
	else
		dir=$(fd --type d --exclude .git --exclude .cache | fzf --prompt="📂 Go to: ")
	fi

	[[ -n "$dir" ]] && cd "$dir"
}

ft() {
	local dir
	dir=$(fd --type d --hidden --exclude .git --exclude .cache . | fzf --prompt="📂 Tree: " --height=40% --reverse --preview 'if [ -d {} ]; then tree -L 2 {}; else bat --color=always {}; fi' --preview-window=right:40%)
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

fe() {
	local file
	file=$(fd --type f --hidden --exclude .git --exclude .cache . | fzf --prompt="📄 Open: ")
	[[ -n "$file" ]] && hx "$file"
}

fea() {
	local file
	file=$(fd --type f --hidden . | fzf --prompt="📄 Open (All): ")
	[[ -n "$file" ]] && hx "$file"
}

fer() {
	local file
	file=$(fd --type f --hidden --exclude .git --exclude .cache . ~ | fzf --prompt="📄 Open Home: ")
	[[ -n "$file" ]] && hx "$file"
}

fet() {
	local file
	file=$(fd --hidden --exclude .git --exclude .cache . | fzf --prompt="📄 Tree: " --height=40% --reverse --preview 'if [ -d {} ]; then tree -L 2 {}; else bat --color=always {}; fi' --preview-window=right:40%)
	[[ -n "$file" ]] && hx "$file"
}
