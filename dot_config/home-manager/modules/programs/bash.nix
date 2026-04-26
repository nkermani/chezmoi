{
  programs.bash = {
    profileExtra = ''
      if [ -f "$HOME/.profile" ]; then . "$HOME/.profile"; fi
    '';
    initExtra = ''
      # NK Custom Config
      export NK_DIR="$HOME/.nkermani"
      export NK_APPS="$NK_DIR/apps"
      export NK_BIN="$NK_DIR/bin"
      export PATH="$NK_BIN:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.cargo/bin:$PATH"

      # Nix (Linux 42 no-sudo)
      if [ "$(uname -s)" = "Linux" ] && [ ! -S /run/current-system/sw/bin/nix-daemon ]; then
        export PATH="$HOME/.local/bin:$PATH"
      fi

      if [ "$(uname -s)" = "Darwin" ]; then
        export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin"
      fi

      # EDITOR


      # Git aliases


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
