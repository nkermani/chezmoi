{
  programs.fish = {
    enable = true;
    shellInit = ''
      # Source Nix profile (macOS or WSL2)
      if test (uname -s) = "Darwin"
        if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
          source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        end
      else if test (uname -s) = "Linux"
        if uname -r | grep -q -i microsoft
          if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
            source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
          end
        end
      end

      # Hide welcome message
      set fish_greeting ""

      # NK Environment Variables
      set -gx NK_DIR "$HOME/.nkermani"
      set -gx NK_APPS "$NK_DIR/apps"
      set -gx NK_BIN "$NK_DIR/bin"

      # NK Custom Config PATH
      if test (uname -s) = "Darwin"
        set -gx PATH $NK_BIN $HOME/.local/bin $HOME/.cargo/bin $PATH
        set -gx PATH $PATH /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin /usr/local/bin /opt/homebrew/bin
      else
        set -gx PATH $NK_BIN $HOME/.local/bin $HOME/.cargo/bin $PATH
      end

      # EDITOR

      set -gx EDITOR "code"
      set -gx VISUAL "code"

      # devenv hook fish | source # Need devenv version to be 2.1

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
