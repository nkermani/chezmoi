{ pkgs, lib, config, inputs, ... }:

{
  packages = [ pkgs.git pkgs.secretspec ];

  languages.nix.enable = true;

  scripts = {
    nix-update.exec = ''
      nix-channel --update
    '';
    switch.exec = ''
      secretspec run -- home-manager switch
    '';
    upgrade.exec = ''
      nix-channel --update && secretspec run -- home-manager switch
    '';
  };

  # See full reference at https://devenv.sh/reference/options/
}
