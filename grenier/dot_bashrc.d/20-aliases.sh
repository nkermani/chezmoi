# dot_bashrc.d/20-aliases.sh

if [[ "$(uname -s)" == "Darwin" ]]; then
	alias code='open -a "Visual Studio Code"'
fi

if [[ "$OS_TYPE" == "wsl2" ]]; then
    unalias code c 2>/dev/null
    export VSCODE_EXE="/mnt/c/Users/kerma/AppData/Local/Programs/Microsoft VS Code/Code.exe"

    vscode() {
        ( "$VSCODE_EXE" --remote wsl+Ubuntu-22.04 "${@:-.}" &> /dev/null & )
    }
    alias c='vscode'
    alias code='vscode'
fi

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gst='git status'

#script
alias gcm='~/.nkermani/bin/gcm'

# lazygit
alias lg='lazygit'
