# 3.2 LAZYGIT ALIAS
alias lg='lazygit'

if [[ "$OS_TYPE" == "linux" ]]; then
    alias gfn='junest geforcenow --no-sandbox"'
    export PATH="$PATH:~/.junest/usr/bin_wrappers"
    export PATH=~/.local/share/junest/bin:$PATH
fi

if [[ "$OS_TYPE" == "macos" ]]; then
    alias code='open -a "Visual Studio Code"'
fi
