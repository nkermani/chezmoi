{ pkgs, ... }: {
  home.packages = [ pkgs.python3Packages.python-lsp-server ];
}
