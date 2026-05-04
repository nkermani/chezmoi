{
  programs.zsh = {
    enable = false;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".zshrc.d/nk-config.zsh".text = ''
      # NK Custom Config
      export NK_DIR="$HOME/.nkermani"
      export NK_APPS="$NK_DIR/apps"
      export NK_BIN="$NK_DIR/bin"

      # Nix (Linux 42 no-sudo setup)
      if [[ "$(uname -s)" = "Linux" ]] && [[ ! -S /run/current-system/sw/bin/nix-daemon ]] && [[ -x "$HOME/nix-user-chroot" ]]; then
        export nix_chroot="$HOME/nix-user-chroot $HOME/.nix"
        export PATH="$HOME/.local/bin:$PATH"
      elif [[ -d "$HOME/.nix-profile/bin" ]]; then
        export PATH="$HOME/.nix-profile/bin:$PATH"
      fi

      # NK Custom Config PATH
      if [[ "$(uname -s)" = "Darwin" ]]; then
        export PATH="$NK_BIN:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.cargo/bin:$PATH"
        export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/usr/local/bin:/opt/homebrew/bin"
      else
        export PATH="$NK_BIN:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.cargo/bin:$PATH"
      fi

      # EDITOR
      export EDITOR="code"
      export VISUAL="code"

      # Aliases
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
      alias glog='git log --oneline --graph --decorate'
      alias gcl='git clone'

      # Utilities
      alias lg='lazygit'
      alias y='yazi'
      alias cat='bat'
      alias ls='eza --icons=auto'
      alias ll='eza -l --icons=auto'
      alias la='eza -la --icons=auto'
      alias lt='eza --tree --icons=auto'

      # eval "$(devenv hook zsh)" # Need devenv version to be 2.1

      # AI Tooling
      alias specsmd='npx specsmd@latest'

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
}
