# dot_bashrc.d/10-env.sh

if [[ "$UNAME_S" == "Darwin" ]]; then
    OS_TYPE="macos"
elif grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
    OS_TYPE="wsl2"
else
    OS_TYPE="linux"
fi

# EDITOR / VISUAL / GIT_EDITOR
if command -v code >/dev/null 2>&1; then
    _preferred_editor=code
elif command -v zed >/dev/null 2>&1; then
    _preferred_editor=zed
elif command -v hx >/dev/null 2>&1; then
    _preferred_editor=hx
elif command -v vim >/dev/null 2>&1; then
    _preferred_editor=vim
elif command -v vi >/dev/null 2>&1; then
    _preferred_editor=vi
elif command -v nano >/dev/null 2>&1; then
    _preferred_editor=nano
else
    _preferred_editor=hx
fi

export EDITOR="$_preferred_editor"
export VISUAL="$_preferred_editor"
export GIT_EDITOR="$_preferred_editor"
unset _preferred_editor
