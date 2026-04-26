{
  programs.fish = {
    enable = true;
    shellInit = ''
      # Hide welcome message
      set fish_greeting

      # NK Environment Variables
      set -gx NK_DIR "$HOME/.nkermani"
      set -gx NK_APPS "$NK_DIR/apps"
      set -gx NK_BIN "$NK_DIR/bin"

      # Nix (Linux 42 no-sudo setup)
      if test (uname -s) = "Linux"
        and test ! -S /run/current-system/sw/bin/nix-daemon
        and test -x "$HOME/nix-user-chroot"
          set -gx nix_chroot "$HOME/nix-user-chroot $HOME/.nix"
          set -gx PATH $HOME/.local/bin $PATH
      else if test -d "$HOME/.nix-profile/bin"
          set -gx PATH $HOME/.nix-profile/bin $PATH
      end

      # NK Custom Config PATH
      if test (uname -s) = "Darwin"
        set -gx PATH $NK_BIN $HOME/.local/bin $HOME/.cargo/bin $PATH
        set -gx PATH $PATH /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin /usr/local/bin /opt/homebrew/bin
      else
        set -gx PATH $NK_BIN $HOME/.local/bin $HOME/.cargo/bin $PATH
      end

      # EDITOR

      # Directory navigation functions
      function f
        set -l dir
        if test "$1" = "-a"
          set dir (fd --type d --hidden --exclude .git --exclude .cache | fzf --prompt="Go to (All): ")
        else if test "$1" = "-t"
          set dir (fd --type d --hidden --exclude .git --exclude .cache . | fzf --prompt="Go to (Tree): " --height=40% --layout=reverse-list)
        else
          set dir (fd --type d --exclude .git --exclude .cache | fzf --prompt="Go to: ")
        end
        if test -n "$dir"
          cd $dir
        end
      end

      function fr
        set -l dir
        if test "$1" = "-a"
          set dir (fd --type d --hidden . ~ | fzf --prompt="Go to Home (All): ")
        else
          set dir (fd --type d --exclude .git --exclude .cache . ~ | fzf --prompt="Go to Home: ")
        end
        if test -n "$dir"
          cd $dir
        end
      end

      function fe
        set -l file
        set file (fd --type f --hidden --exclude .git --exclude .cache . | fzf --prompt="Open: ")
        if test -n "$file"
          hx $file
        end
      end
    '';
  };
}