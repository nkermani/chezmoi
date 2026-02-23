# 7. INITIALISATIONS OPTIMISÉES (Lazy-loading)
# FZF & Zoxide
[ -n "$commands[fzf]" ] && source <(fzf --zsh 2>/dev/null || fzf --bash 2>/dev/null)
[ -n "$commands[zoxide]" ] && eval "$(zoxide init zsh)"

export FZF_DEFAULT_COMMAND='fd --type f --absolute-path'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden'

# bat
if command -v bat >/dev/null 2>&1; then
    export BAT_THEME="CyberpunkNK"
fi

# NVM
if [ -d "/goinfre/$USER/.nvm" ]; then
    export NVM_DIR="/goinfre/$USER/.nvm"
else
    export NVM_DIR="$HOME/.nkermani/apps/nvm"
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# NVM Lazy-load
if [ -s "$NVM_DIR/nvm.sh" ]; then
    nvm() {
        unfunction nvm node npm
        source "$NVM_DIR/nvm.sh"
        nvm "$@"
    }
    node() {
        unfunction nvm node npm
        source "$NVM_DIR/nvm.sh"
        node "$@"
    }
    npm() {
        unfunction nvm node npm
        source "$NVM_DIR/nvm.sh"
        npm "$@"
    }
fi

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# bun completions
[ -s "/home/nkermani/.nkermani/apps/bun/_bun" ] && source "/home/nkermani/.nkermani/apps/bun/_bun"

# bun
export BUN_INSTALL="$HOME/.nkermani/apps/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
