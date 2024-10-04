{ pkgs }:
pkgs.stdenv.mkDerivation rec {
	pname = "rofi-themes";
	version = "1.0";

	src = pkgs.fetchFromGitHub {
		owner = "newmanls";
		repo = "rofi-themes-collection";
		rev = "master";
		sha256 = "sha256-1F+qMwchTUWdEWpsIqyVG5pYmqdvmsCckvSmg7pYjdY=";
	};

	installPhase = ''
		mkdir -p $out/share/rofi/themes
		cp -r themes/* $out/share/rofi/themes/
	'';
}
