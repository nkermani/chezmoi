# 4. LOGIQUE VS CODE (WSL2)
if [[ "$OS_TYPE" == "wsl2" ]]; then
    unalias code c 2>/dev/null
    export VSCODE_EXE="/mnt/c/Users/kerma/AppData/Local/Programs/Microsoft VS Code/Code.exe"

    vscode() {
        ( "$VSCODE_EXE" --remote wsl+Ubuntu-22.04 "${@:-.}" &> /dev/null & )
    }
    alias c='vscode'
fi

# SMART-EDITOR
mkdir -p "$NK_BIN"
cat << 'EOF' > "$NK_BIN/smart-editor"
#!/usr/bin/env bash

# 1. Arguments par défaut
[ $# -eq 0 ] && set -- "."

W_CODE="/mnt/c/Users/kerma/AppData/Local/Programs/Microsoft VS Code/Code.exe"

if command -v nvim >/dev/null 2>&1; then
    exec nvim "$@"
fi

if grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
    if [[ -f "$W_CODE" ]]; then
        "$W_CODE" --remote wsl+Ubuntu-22.04 "$@" &> /dev/null &
        exit 0
    fi
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
    if command -v code >/dev/null 2>&1; then
        open -a "Visual Studio Code" "$@"
        exit 0
    fi
fi

if command -v code >/dev/null 2>&1; then
    exec code "$@"
else
    exec vi "$@"
fi
EOF

chmod +x "$NK_BIN/smart-editor"
export EDITOR="smart-editor"
export VISUAL="smart-editor"

alias edit='smart-editor'
alias e='smart-editor'
alias c='code'
alias v='vim'
alias n='nvim'

