# ~/.bashrc.d/00-env.sh - shared NKERMANI env for bash
export NK_DIR="$HOME/.nkermani"
export NK_APPS="$NK_DIR/apps"
export NK_BIN="$NK_DIR/bin"
export PATH="$NK_BIN:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.cargo/bin:$PATH"

# Set default shell to user-installed bash if available
if [ -x "$NK_BIN/bash" ]; then
    export SHELL="$NK_BIN/bash"
else
    export SHELL="$(command -v bash 2>/dev/null || echo /bin/bash)"
fi

# OSX / Linux path helpers
if [ "$(uname -s)" = "Darwin" ]; then
    export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
else
    export PATH="$HOME/.OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7 OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7/jdk-21.0.10+7/bin:$PATH"
    export PATH="$HOME/.local/share/junest/bin:$PATH"
fi

export PATH

# Prefer Helix editor (`hx`) if available, otherwise keep existing EDITOR
if command -v hx >/dev/null 2>&1; then
    _preferred_editor=hx
elif command -v vim >/dev/null 2>&1; then
    _preferred_editor=vim
elif command -v vi >/dev/null 2>&1; then
    _preferred_editor=vi
elif command -v code >/dev/null 2>&1; then
    _preferred_editor=code
elif command -v nano >/dev/null 2>&1; then
    _preferred_editor=nano
else
    _preferred_editor=hx
fi

export EDITOR="$_preferred_editor"
export VISUAL="$_preferred_editor"
export GIT_EDITOR="$_preferred_editor"
unset _preferred_editor
