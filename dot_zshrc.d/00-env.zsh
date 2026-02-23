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

# 2. TERM HANDLING
if [[ "$TERM" == "alacritty" ]] || [[ -n "$ALACRITTY_WINDOW_ID" ]]; then
    _IS_ALACRITTY=1
fi

# Fallback if TERM is unknown or forced to something missing
if ! tput colors >/dev/null 2>&1; then
    export TERM="xterm-256color"
fi

# On ne force TERM que si on est sûr d'être dans Alacritty ou si on est hors-tmux
if [[ -z "$TMUX" ]]; then
    if [[ -n "$_IS_ALACRITTY" ]]; then
        # On ne remet alacritty que si tput a réussi (donc si terminfo est présent)
        # Sinon on reste en xterm-256color pour éviter les bugs d'affichage
        tput colors >/dev/null 2>&1 && export TERM="alacritty"
    elif [[ "$OS_TYPE" == "wsl2" ]]; then
        export TERM="xterm-256color"
    fi
fi

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
    # Ajoute les chemins standards de Homebrew et de VS Code
    export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
    export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
fi
typeset -U path
path=($NK_BIN $HOME/.local/bin $HOME/.opencode/bin $HOME/.cargo/bin /usr/local/bin $path)

# 2.2 Vos dossiers perso (en fin de liste pour ne pas masquer les binaires système essentiels)
export PATH="$LSP:$NK_BIN:$PATH"
