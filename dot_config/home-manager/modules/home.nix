{ config, lib, ... }:

{
  home.username = "nkermani";
  home.homeDirectory = lib.mkDefault (builtins.getEnv "HOME");
  home.stateVersion = "24.11";

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
