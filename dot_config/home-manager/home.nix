{ config, pkgs, ... }:

{
  imports = [
    ./modules/home.nix
    ./modules/packages.nix
    ./modules/shell-aliases.nix
    ./modules/programs/bash.nix
    ./modules/programs/git.nix
    ./modules/programs/yazi.nix
    ./modules/programs/btop.nix
    ./modules/programs/bat.nix
    ./modules/programs/lazygit.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}