{ config, pkgs, lib, ... }:

{
  programs.lazyvim = {
    enable = true;

    # Core LazyVim dependencies (git, ripgrep, fd, etc.)
    installCoreDependencies = true;

    extras = {
      lang = {
        clangd = {
          enable = true;
          installDependencies = true;
        };
        dotnet = {
          enable = true;
          installDependencies = true;
        };
        python = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        rust = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        typescript = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        go = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        nix = {
          enable = true;
          installDependencies = true;
        };
        zig = {
          enable = true;
          installDependencies = true;
        };
        php = {
          enable = true;
          installDependencies = true;
        };
      };
    };

    extraPackages = with pkgs; [
      # LSP Servers (extra coverage beyond what lazyvim-nix extras install)
      csharp-ls
      basedpyright
      python3Packages.python-lsp-server
      typescript-language-server
      perlnavigator
      phpactor
    ];
  };

  # Nix-built treesitter parsers require glibc 2.38+ but the host system (Ubuntu)
  # has glibc 2.35. Override with empty dir so LazyVim compiles parsers natively
  # (they'll link against the system glibc and work fine).
  xdg.dataFile."nvim/site/parser" = lib.mkForce {
    source = pkgs.runCommand "empty-parsers" {} "mkdir -p $out";
  };

  # Override queries too to avoid stale symlink issues
  xdg.dataFile."nvim/site/queries" = lib.mkForce {
    source = pkgs.runCommand "empty-queries" {} "mkdir -p $out";
  };

  # Replace read-only Nix store symlink with a writable directory so TSInstall
  # can compile and install parsers natively against the system glibc.
  home.activation.removeNixParserSymlinks = lib.hm.dag.entryAfter ["linkGeneration"] ''
    for dir in "$HOME/.local/share/nvim/site/parser" "$HOME/.local/share/nvim/site/queries"; do
      if [ -L "$dir" ]; then
        rm "$dir"
      fi
      mkdir -p "$dir"
    done
  '';

  # gcc needed by nvim-treesitter to compile parsers via :TSInstall
  # statix,deadnix: Nix linters used by nvim-lint (LazyVim nix extra)
  home.packages = with pkgs; [ gcc statix deadnix ];
}
