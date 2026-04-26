{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    # Runtimes
    pkgs.nodejs_22
    pkgs.rustc
    pkgs.cargo
    pkgs.bun
    pkgs.devenv

    # CLI Tools
    pkgs.fzf
    pkgs.ripgrep
    pkgs.fd
    pkgs.bat
    pkgs.lazygit
    pkgs.tree
    pkgs.eza
    pkgs.yazi
    pkgs.btop
    pkgs.opencode

    pkgs.bash
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
