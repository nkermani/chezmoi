# 3. OH-MY-ZSH (Chargement silencieux)
# ZSH_THEME="robbyrussell" # Disabled for Starship
plugins=(git zsh-syntax-highlighting zsh-autosuggestions auto-notify you-should-use zsh-history-substring-search)
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# 3.1 STARSHIP PROMPT
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
