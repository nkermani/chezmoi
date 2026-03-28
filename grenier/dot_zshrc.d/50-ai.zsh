ai() {
    local search_cmd
    local hidden_flag=""

    if [[ "$1" == "-a" ]]; then
        search_cmd="fd --type d --hidden --exclude .git --exclude .cache ."
    elif [[ -n "$1" ]]; then
        opencode "$1"
        return
    else
        search_cmd="fd --type d ."
    fi

    local target=$(eval "$search_cmd" | fzf \
        --prompt="󰚝 OpenCode (Local): " \
        --header="Select a folder to start agent")

    [[ -n "$target" ]] && cd "$target" && opencode .
}

air() {
    local search_cmd
    if [[ "$1" == "-a" ]]; then
        search_cmd="fd --type d --hidden . ~"
    else
        search_cmd="fd --type d --exclude .git --exclude .cache . ~"
    fi

    local target=$(eval "$search_cmd" | fzf \
        --prompt="󰚝 OpenCode (Global ~/): " \
        --header="Search folders from home")

    [[ -n "$target" ]] && cd "$target" && opencode .
}

alias ai-all='ai'
alias aichat='opencode chat'
alias aip='opencode project'
alias aie='opencode explain'
alias gcm='~/.nkermani/scripts/gcm.sh'
