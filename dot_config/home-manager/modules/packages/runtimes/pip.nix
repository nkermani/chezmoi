{ pkgs, ... }: {
  home.packages = [ pkgs.python3Packages.pip ];
}
