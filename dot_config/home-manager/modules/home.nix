{ config, pkgs, ... }:

{
  home.username = "nkermani";
  home.homeDirectory = "/home/nkermani";
  home.stateVersion = "24.11";

  xdg.configFile = {
    "fontconfig/fonts.conf".text = ''
      <?xml version="1.0" encoding="utf-8"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <dir prefix="cwd">/home/nkermani/.nix-profile/share/fonts</dir>
        <dir prefix="cwd">/home/nkermani/.local/share/fonts</dir>
      </fontconfig>
    '';
    "fish/config.fish".text = ''
      # Load nix
      if test -f ~/.nix-profile/etc/profile.d/nix-daemon.fish
        source ~/.nix-profile/etc/profile.d/nix-daemon.fish
      end

      # Add Nix bin to PATH
      if test -d ~/.nix-profile/bin
        set -gx PATH ~/.nix-profile/bin $PATH
      end
    '';
  };

  home.sessionVariables = {
    PATH = "$HOME/.local/bin:$PATH";
    STUDENT_USERNAME = "nkermani";
    STUDENT_EMAIL = "nima.kermani@example.com";
  };
}
