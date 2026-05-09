{ config, pkgs, lib, ... }:

let
  version = "1.2.1";
  gramPkg = pkgs.stdenv.mkDerivation {
    pname = "gram";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://codeberg.org/GramEditor/gram/releases/download/${version}/gram-linux-x86_64-${version}.tar.gz";
      hash = "sha256-KNFiOjLI2Z/klHVOsap7NNZpBOebwZp/oux3LDq69F8=";
    };

    sourceRoot = "gram.app";

    installPhase = ''
      mkdir -p $out/bin $out/lib $out/libexec $out/share
      cp bin/gram $out/bin/
      cp -r lib/* $out/lib/
      cp -r libexec/* $out/libexec/
      cp -r share/* $out/share/
    '';

    meta = {
      description = "A code editor for humanoid apes and grumpy toads";
      homepage = "https://gram.liten.app";
      license = lib.licenses.gpl3Only;
      platforms = [ "x86_64-linux" ];
    };
  };
in
{
  home.packages = lib.optionals pkgs.stdenv.isLinux [ gramPkg ];
}
