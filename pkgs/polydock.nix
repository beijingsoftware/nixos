{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "polydock";
  version = "2.1.0";

  src = pkgs.fetchurl {
    url = "https://github.com/folke/polydock/releases/download/${version}/polydock-bin-${version}.zip";
    sha256 = "sha256-jCVwRUMnMG9+jIOcoTz0Xu3fS+4gT3oyNH5KJ2Y60z0=";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  unpackPhase = ''
    mkdir -p $out
    unzip $src -d $out
  '';

}
