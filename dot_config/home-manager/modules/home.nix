{ config, lib, ... }:

{
  home.username = "nkermani";
  home.homeDirectory = lib.mkDefault (builtins.getEnv "HOME");
  home.stateVersion = "24.11";

  programs = {
    bat.enable = true;
    broot.enable = true;
    btop.enable = true;
    eza.enable = true;
    fish.enable = true;
    vscode.enable = false;
    git.enable = true;
    helix.enable = false;
    lazyvim.enable = false;
    neovide.enable = false;
    opencode.enable = false;
    uv.enable = true;
    "zed-editor".enable = false;
    "fresh-editor".enable = true;
  };

  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0" encoding="utf-8"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <dir prefix="cwd">${config.home.homeDirectory}/.nix-profile/share/fonts</dir>
      <dir prefix="cwd">${config.home.homeDirectory}/.local/share/fonts</dir>
    </fontconfig>
  '';

  home.sessionVariables = {
    PATH = "$HOME/bin:$HOME/.local/bin:$PATH";
    STUDENT_USERNAME = "nkermani";
    STUDENT_EMAIL = "nkermani@student.42lyon.fr";
  };
}
