{ config, pkgs, ... }:

let
  latestRelease = builtins.fromJSON (builtins.readFile (builtins.fetchurl {
    url = "https://api.github.com/repos/microsoft/vscode/releases/latest";
  }));
  vscodeVersion = latestRelease.tag_name;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.overrideAttrs (old: {
      version = vscodeVersion;

      src = builtins.fetchurl {
        url = "https://update.code.visualstudio.com/${vscodeVersion}/linux-x64/stable";
        name = "VSCode_${vscodeVersion}_linux-x64.tar.gz";
      };
    });
  };
}
