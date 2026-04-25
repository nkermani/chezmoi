{
  programs.fish.enable = true;
  programs.bash.enable = true;

  programs.bash = {
    enable = true;
    profileAdditional = ''
      if [ -f "$HOME/.profile" ]; then . "$HOME/.profile"; fi
    '';
    bashrcExtraContent = ''
      # NK Custom Config
      export NK_DIR="$HOME/.nkermani"
      export NK_APPS="$NK_DIR/apps"
      export NK_BIN="$NK_DIR/bin"
      export PATH="$NK_BIN:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.cargo/bin:$PATH"

      if [ "$(uname -s)" = "Darwin" ]; then
        export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
      fi

      # EDITOR
      export EDITOR="hx"
      export VISUAL="hx"
      export GIT_EDITOR="hx"

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
      alias lg='lazygit'

      # Directory navigation functions
      f() {
        local dir
        if [[ "$1" == "-a" ]]; then
          dir=$(fd --type d --hidden --exclude .git --exclude .cache | fzf --prompt="Go to (All): ")
        elif [[ "$1" == "-t" ]]; then
          dir=$(fd --type d --hidden --exclude .git --exclude .cache . | fzf --prompt="Go to (Tree): " --height=40% --layout=reverse-list)
        else
          dir=$(fd --type d --exclude .git --exclude .cache | fzf --prompt="Go to: ")
        fi
        [[ -n "$dir" ]] && cd "$dir"
      }

      fr() {
        local dir
        if [[ "$1" == "-a" ]]; then
          dir=$(fd --type d --hidden . ~ | fzf --prompt="Go to Home (All): ")
        else
          dir=$(fd --type d --exclude .git --exclude .cache . ~ | fzf --prompt="Go to Home: ")
        fi
        [[ -n "$dir" ]] && cd "$dir"
      }

      fe() {
        local file
        file=$(fd --type f --hidden --exclude .git --exclude .cache . | fzf --prompt="Open: ")
        [[ -n "$file" ]] && hx "$file"
      }
    '';
  };
}