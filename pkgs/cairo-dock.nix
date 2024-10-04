{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "cairo-dock";
  version = "3.4.1";

  src = pkgs.fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = "cairo-dock-core";
    rev = "${version}";
    sha256 = "sha256-BksqGqdhf2c3NwNJ2/A4cuFAchZHi7hx6ADeAC+xfVg=";
  };

  nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config ];

  buildInputs = with pkgs; [
    gtk3 cairo librsvg dbus dbus-glib libxml2 xorg.libXrender xorg.libXrandr xorg.libXtst xorg.libXcomposite xorg.libX11 xorg.libXxf86vm
    libetpan libxklavier webkitgtk libexif vte zeitgeist python3 curl wget mesa libGLU
  ];

  # The plugins source
  pluginsSrc = pkgs.fetchFromGitHub {
    owner = "Cairo-Dock";
    repo = "cairo-dock-plug-ins";
    rev = "${version}";
    sha256 = "sha256-jYmGk8MkoOT0aXLmOD3BSEu9iefio3m9iR1PqK0Nj7M=";
  };

}
