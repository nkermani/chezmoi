{ config, pkgs, lib, ... }:

let
  systemMap = {
    "x86_64-linux" = "opencode-linux-x64";
    "aarch64-linux" = "opencode-linux-arm64";
  };
  pkgName = systemMap.${pkgs.stdenv.hostPlatform.system} or (throw "Unsupported system: ${pkgs.stdenv.hostPlatform.system}");

  latestInfo = builtins.fromJSON (builtins.readFile (builtins.fetchurl {
    url = "https://registry.npmjs.org/${pkgName}/latest";
  }));
  version = latestInfo.version;

  opencodePackage = pkgs.stdenv.mkDerivation {
    name = "${pkgName}-${version}";
    inherit version;

    src = builtins.fetchurl {
      url = "https://registry.npmjs.org/${pkgName}/-/${pkgName}-${version}.tgz";
      name = "${pkgName}-${version}.tgz";
    };

    sourceRoot = "package";

    dontStrip = true;

    installPhase = ''
      install -m 755 -D bin/opencode $out/bin/opencode
    '';

    meta = {
      description = "AI-powered coding assistant that runs on your CLI";
      homepage = "https://opencode.ai";
      license = lib.licenses.mit;
      platforms = [ "x86_64-linux" "aarch64-linux" ];
    };
  };
in
{
  home.packages = [ opencodePackage ];
}
