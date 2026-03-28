# SSH/SCP/SFTP - Fix pour les machines distantes
# Utilise kitten ssh pour Kitty, sinon xterm-256color pour les autres

_ssh_wrapper() {
    # Si on est dans Kitty et que c'est un appel ssh
    if [[ "$_IS_KITTY" -eq 1 ]] && [[ "$1" == "ssh" ]]; then
        local kitten_cmd=""
        if command -v kitten &>/dev/null; then
            kitten_cmd="kitten"
        elif [[ -x "$HOME/.local/kitty.app/bin/kitten" ]]; then
            kitten_cmd="$HOME/.local/kitty.app/bin/kitten"
        fi
        
        if [[ -n "$kitten_cmd" ]]; then
            # Skip first arg (ssh) and pass the rest to kitten ssh
            "$kitten_cmd" ssh "${@:2}"
            return $?
        fi
    fi
    
    # Si on est dans Alacritty, tmux, screen ou Windows Terminal
    if [[ "$TERM" == "alacritty" ]] || [[ "$TERM" == "kitty" ]] || \
         [[ "$TERM" == tmux* ]] || [[ "$TERM" == screen* ]] || \
         [[ "$_IS_WINDOWS_TERM" -eq 1 ]]; then
        TERM=xterm-256color "$@"
    else
        command "$@"
    fi
}

alias ssh='_ssh_wrapper ssh'
alias scp='_ssh_wrapper scp'
alias sftp='_ssh_wrapper sftp'

alias clear='clear -x'
