{ config, pkgs, ... }:

## Custom install package bad practice, bad way as it is onesided install can't uninstall by simply disabling it.
let
  latestRelease = builtins.fromJSON (builtins.readFile (builtins.fetchurl {
    url = "https://api.github.com/repos/microsoft/vscode/releases/latest";
  }));
  vscodeVersion = latestRelease.tag_name;
in
{
  programs.vscode = {
    package = pkgs.vscode.overrideAttrs (old: {
      version = vscodeVersion;

      src = builtins.fetchurl {
        url = "https://update.code.visualstudio.com/${vscodeVersion}/linux-x64/stable";
        name = "VSCode_${vscodeVersion}_linux-x64.tar.gz";
      };

      # Ensure the ripgrep directory exists and handle missing binary in newer VS Code versions
      postPatch = ''
        mkdir -p resources/app/node_modules/@vscode/ripgrep/bin
        rm -rf resources/app/node_modules/@github/copilot-linuxmusl-x64
      '' + builtins.replaceStrings
        ["rm resources/app/node_modules/@vscode/ripgrep/bin/rg"]
        ["rm -f resources/app/node_modules/@vscode/ripgrep/bin/rg"]
        old.postPatch;
    });
  };
}
