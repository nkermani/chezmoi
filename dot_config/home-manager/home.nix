{ config, pkgs, ... }:

{
  imports = [
    ./modules/home.nix
    ./modules/shell-aliases.nix
    ./modules/packages
    ./modules/config
  ];

  programs.home-manager.enable = true;
}
