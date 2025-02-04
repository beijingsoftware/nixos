{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "slstatus";
  version = "1.0";

  src = ../slstatus;

  buildInputs = with pkgs; [ xorg.libX11 ];

  installPhase = ''
               mkdir -p $out/bin
               cp slstatus $out/bin/
  '';
  
  
  
}
