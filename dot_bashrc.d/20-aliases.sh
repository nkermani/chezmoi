# 3.2 LAZYGIT ALIAS
alias lg='lazygit'

if [[ "$(uname -s)" == "Darwin" ]]; then
	alias code='open -a "Visual Studio Code"'
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
alias gcm='~/.nkermani/bin/gcm'
