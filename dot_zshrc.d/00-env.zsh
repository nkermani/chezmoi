# 1. DÉTECTION OS (Rapide)
UNAME_S=$(uname -s)
stty -ixon # Désactive CTRL+S / CTRL+Q pour le flow control
if [[ "$UNAME_S" == "Darwin" ]]; then
    OS_TYPE="macos"
elif grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
    OS_TYPE="wsl2"
else
    OS_TYPE="linux"
fi

export NK_DIR="$HOME/.nkermani"
export NK_APPS="$NK_DIR/apps"
export NK_BIN="$NK_DIR/bin"

# 2. TERM HANDLING - Détection du terminal
_IS_ALACRITTY=0
_IS_KITTY=0
_IS_WINDOWS_TERM=0

# Détection Alacritty
if [[ "$TERM" == "alacritty" ]] || [[ -n "$ALACRITTY_WINDOW_ID" ]]; then
    _IS_ALACRITTY=1
fi

# Détection Kitty
if [[ "$TERM" == "kitty" ]] || [[ -n "$KITTY_WINDOW_ID" ]]; then
    _IS_KITTY=1
fi

# Détection Windows Terminal (WSL2)
if [[ "$OS_TYPE" == "wsl2" ]]; then
    _IS_WINDOWS_TERM=1
    if [[ -n "$WT_SESSION" ]]; then
        _IS_WINDOWS_TERM=1
    fi
fi

# Fallback si TERM est inconnu ou absent
if ! tput colors >/dev/null 2>&1; then
    export TERM="xterm-256color"
fi

# Application du TERM approprié selon le terminal
if [[ -z "$TMUX" ]]; then
    if [[ "$_IS_KITTY" -eq 1 ]]; then
        tput colors >/dev/null 2>&1 && export TERM="kitty"
    elif [[ "$_IS_ALACRITTY" -eq 1 ]]; then
        tput colors >/dev/null 2>&1 && export TERM="alacritty"
    elif [[ "$_IS_WINDOWS_TERM" -eq 1 ]]; then
        export TERM="xterm-256color"
    fi
fi

export _IS_ALACRITTY
export _IS_KITTY
export _IS_WINDOWS_TERM

# 2.1 PATH & ENV
export LSP="$NK_BIN/lsp"
export ZSH="$NK_APPS/ohmyzsh"
export NVM_DIR="$HOME/.nvm"
export ZSH_CUSTOM="$ZSH/custom"

export GOOGLE_CLOUD_PROJECT="opencode-42"

if [[ "$OS_TYPE" == "linux" ]]; then
    export PATH="$HOME/.OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7/OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7/jdk-21.0.10+7/bin:$PATH"
    export PATH="~/.local/share/junest/bin:$PATH"
fi

if [[ "$UNAME_S" == "Darwin" ]]; then
    export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
    export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
fi
typeset -U path
path=($NK_BIN $HOME/.local/bin $HOME/.opencode/bin $HOME/.cargo/bin /usr/local/bin $path)

# 2.2 Vos dossiers perso
export PATH="$LSP:$NK_BIN:$PATH"
