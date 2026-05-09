{ config, pkgs, lib, ... }:

let
  version = "1.1.7";
  zedPkg = pkgs.stdenv.mkDerivation {
    pname = "zed-editor";
    inherit version;

    src = if pkgs.stdenv.isLinux then pkgs.fetchurl {
      url = "https://cloud.zed.dev/releases/stable/${version}/download?asset=zed&arch=x86_64&os=linux&source=docs";
      hash = "sha256-468sG2UwfmRYPoj+5SfvFjyd9VaCUXwdtMmjPxrv5tQ=";
    } else throw "zed-editor: unsupported system (only x86_64-linux is packaged; use the official installer on macOS)";

    sourceRoot = ".";
    dontConfigure = true;
    dontBuild = true;
    unpackPhase = "tar xzf $src";

    installPhase = ''
      mkdir -p $out/bin $out/libexec $out/share
      cp zed.app/bin/zed $out/bin/
      ln -s $out/bin/zed $out/bin/zeditor
      cp -r zed.app/libexec/* $out/libexec/
      cp -r zed.app/share/* $out/share/
    '';

    meta = {
      homepage = "https://zed.dev";
      license = lib.licenses.gpl3Only;
      platforms = [ "x86_64-linux" ];
    };
  };
in
{
  home.packages = [ zedPkg ];
}
