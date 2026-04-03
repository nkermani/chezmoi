# ~/.bashrc.d/00-pah.sh
# PATH
export NK_DIR="$HOME/.nkermani"
export NK_APPS="$NK_DIR/apps"
export NK_BIN="$NK_DIR/bin"
export PATH="$NK_BIN:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.cargo/bin:$PATH"

if [ -x "$NK_BIN/bash" ]; then
    export SHELL="$NK_BIN/bash"
else
    export SHELL="$(command -v bash 2>/dev/null || echo /bin/bash)"
fi

if [ "$(uname -s)" = "Darwin" ]; then
    export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
else
    # TEMP for 42 (Ghidra)
    export PATH="$HOME/.OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7 OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7/jdk-21.0.10+7/bin:$PATH"
fi

export PATH