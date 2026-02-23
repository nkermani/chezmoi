# CAT / BAT
if command -v bat >/dev/null 2>&1; then
    alias cat='bat'
elif command -v batcat >/dev/null 2>&1; then
    alias cat='batcat'
fi

_get_viewer() {
    command -v bat >/dev/null 2>&1 && echo "bat --color=always --style=numbers" || \
        command -v batcat >/dev/null 2>&1 && echo "batcat --color=always --style=numbers" || \
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

yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

alias y='yy .'

yf() {
    local dir
    if [[ "$1" == "-a" ]]; then
        dir=$(fd --type d --hidden --exclude .git --exclude .cache | fzf --prompt="󰇥 Yazi (All): ")
    else
        dir=$(fd --type d --exclude .git --exclude .cache | fzf --prompt="󰇥 Yazi: ")
    fi
    [[ -n "$dir" ]] && yy "$dir"
}

yfr() {
    local dir
    if [[ "$1" == "-a" ]]; then
        dir=$(fd --type d --hidden . ~ | fzf --prompt="󰇥 Yazi Home (All): ")
    else
        dir=$(fd --type d --exclude .git --exclude .cache . ~ | fzf --prompt="󰇥 Yazi Home: ")
    fi
    [[ -n "$dir" ]] && yy "$dir"
}

fe() {
    local v=$(_get_viewer)
    local fd_cmd=("fd" "-a" "--type" "f" "--exclude" ".git" "--exclude" ".cache")
    local query=""

    if [[ "$1" == "-a" ]]; then
        fd_cmd+=("--hidden")
        query="$2"
    else
        query="$1"
    fi

    local file=$("${fd_cmd[@]}" | fzf --query "$query" --preview "$v {}")
    [[ -n "$file" ]] && smart-editor "$file"
}

fre() {
    local v=$(_get_viewer)
    local fd_cmd=("fd" "-a" "--type" "f")

    if [[ "$1" == "-a" ]]; then
        fd_cmd+=("--hidden")
    fi
    fd_cmd+=("--exclude" ".git" "--exclude" ".cache" "--exclude" "Library" "--exclude" "Music" "--exclude" "Movies" "--exclude" "Pictures" "--exclude" "Desktop" "--exclude" "Public" "--exclude" ".Trash")

    local file=$("${fd_cmd[@]}" . ~ | fzf --query "$1" --preview "$v {}")
    [[ -n "$file" ]] && smart-editor "$file"
}

fo() {
    local dir
    local cmd="fd --type d --hidden --exclude .git --exclude .cache"
    [[ "$1" != "-a" ]] && cmd+=" --exclude '.*'"
    dir=$(eval "$cmd" | fzf --prompt="💻 Open with Code: ")
    [[ -n "$dir" ]] && smart-editor "$dir"
}

fro() {
    local dir
    local cmd="fd --type d --hidden"
    [[ "$1" == "-a" ]] && cmd+=""
    cmd+=" . ~"

    [[ "$1" != "-a" ]] && cmd+=" --exclude '.*'"
    dir=$(eval "$cmd" | fzf --prompt="💻 Open Home folder with Code: ")
    [[ -n "$dir" ]] && smart-editor "$dir"
}

_get_viewer() {
    if command -v bat >/dev/null 2>&1; then
        echo "bat --color=always --style=numbers --line-range :500"
    elif command -v batcat >/dev/null 2>&1; then
        echo "batcat --color=always --style=numbers --line-range :500"
    else
        echo "cat"
    fi
}

fcat() { local v=$(_get_viewer); local f=$(fd --type f --hidden --exclude .git --exclude .cache | fzf --preview "$v {}"); [[ -n "$f" ]] && cat "$f"; }
vf()   { local v=$(_get_viewer); local f=$(fd --type f --hidden --exclude .git --exclude .cache | fzf --preview "$v {}"); [[ -n "$f" ]] && smart-editor "$f"; }
vfg()  { local v=$(_get_viewer); local f=$(fd --type f --hidden --exclude .git --exclude .cache . ~ | fzf --preview "$v {}"); [[ -n "$f" ]] && smart-editor "$f"; }
