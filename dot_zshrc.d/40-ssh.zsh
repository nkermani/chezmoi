# SSH/SCP/SFTP - Fix for remote machines not knowing alacritty or tmux-256color
_term_fix_ssh() {
    local cmd=$1
    shift
    case "$TERM" in
        alacritty*|tmux*|screen*)
            TERM=xterm-256color command "$cmd" "$@"
            ;;
        *)
            command "$cmd" "$@"
            ;;
    esac
}
alias ssh='_term_fix_ssh ssh'
alias scp='_term_fix_ssh scp'
alias sftp='_term_fix_ssh sftp'

alias clear='clear -x'
