{ pkgs, ... }:

let
  latestRelease = builtins.fromJSON (builtins.readFile (builtins.fetchurl {
    url = "https://api.github.com/repos/neovide/neovide/releases/latest";
  }));
  neovideVersion = latestRelease.tag_name;
in {
  home.packages = [
    (pkgs.stdenv.mkDerivation {
      pname = "neovide";
      version = neovideVersion;

      src = builtins.fetchurl {
        url = "https://github.com/neovide/neovide/releases/download/${neovideVersion}/neovide-linux-x86_64.tar";
        name = "neovide-${neovideVersion}-linux-x86_64.tar";
      };

      sourceRoot = ".";

      installPhase = ''
        mkdir -p $out/bin
        cp neovide $out/bin/
      '';
    })
  ];
}
