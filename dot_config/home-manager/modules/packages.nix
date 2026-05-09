{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    # Runtimes
    pkgs.devenv # Manages all projects runtime requirements via devenv.nix
    pkgs.python3
    pkgs.python3Packages.pip
    pkgs.nodejs_22
    pkgs.rustc
    pkgs.cargo
    pkgs.bun

    # CLI Tools
    pkgs.fzf # fzf
    pkgs.ripgrep # rg
    pkgs.fd # fd
    pkgs.bat # bat > cat
    pkgs.lazygit # lg
    pkgs.tree # tree
    pkgs.eza # eza > ls
    pkgs.yazi # yazi
    pkgs.btop # btop > htop > top
    pkgs.duckdb # cli for data file previews
    pkgs.scooter # interactive find and replace TUI

    pkgs.opencode # opensource ai

    pkgs.bash # bash
    pkgs.zsh # zsh
    pkgs.fish # fish
    pkgs.nushell # nu
    pkgs.nerd-fonts.jetbrains-mono # font
  ];
}
