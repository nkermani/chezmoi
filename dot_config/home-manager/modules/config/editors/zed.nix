{ config, pkgs, lib, ... }:

## Custom install package bad practice, bad way as it is onesided install can't uninstall by simply disabling it.
let
  latestRelease = builtins.fromJSON (builtins.readFile (builtins.fetchurl {
    url = "https://api.github.com/repos/zed-industries/zed/releases/latest";
  }));
  version = latestRelease.tag_name;
  arch = if pkgs.stdenv.hostPlatform.system == "aarch64-linux" then "aarch64" else "x86_64";

  zedPackage = pkgs.stdenv.mkDerivation {
    pname = "zed-editor";
    inherit version;

    src = builtins.fetchurl {
      url = "https://github.com/zed-industries/zed/releases/download/${version}/zed-linux-${arch}.tar.gz";
      name = "zed-linux-${arch}.tar.gz";
    };

    sourceRoot = "zed.app";

    dontPatchELF = true;
    dontStrip = true;

    installPhase = ''
      mkdir -p $out/bin $out/libexec $out/share

      cp -r bin/* $out/bin/
      cp -r libexec/* $out/libexec/
      cp -r share/* $out/share/
      cp -r lib $out/

      ln -s $out/bin/zed $out/bin/zeditor
    '';

    meta = {
      description = "High-performance, multiplayer code editor from the creators of Atom and Tree-sitter";
      homepage = "https://zed.dev";
      license = lib.licenses.gpl3Only;
      mainProgram = "zeditor";
      platforms = lib.platforms.linux;
    };
  };
in
{
  programs.zed-editor = {
    package = zedPackage;
  };
}
