{ pkgs }:

pkgs.stdenv.mkDerivation rec {
        pname = "custom-icons";
        version = "1.0";

        src = null;

        phases = [ "installPhase" ];

        nativeBuildInputs = [ pkgs.gtk3 ];

        dontDropIconThemeCache = true;

	installPhase = ''
		mkdir -p $out/share/icons
		
		cp -r --no-preserve=mode ${pkgs.whitesur-icon-theme}/share/icons/* $out/share/icons

#		rm -rf $out/share/icons/WhiteSur-dark/status/16/nm-*
#		rm -rf $out/share/icons/WhiteSur-dark/status/22/nm-*
#		rm -rf $out/share/icons/WhiteSur-dark/status/24/nm-*
		rm -rf $out/share/icons/WhiteSur-dark/status

#		cp -r --no-preserve=mode ${pkgs.iconpack-obsidian}/share/icons/Obsidian/status/16/nm-* $out/share/icons/WhiteSur-dark/status/16/
#		cp -r --no-preserve=mode ${pkgs.iconpack-obsidian}/share/icons/Obsidian/status/22/nm-* $out/share/icons/WhiteSur-dark/status/22/
#		cp -r --no-preserve=mode ${pkgs.iconpack-obsidian}/share/icons/Obsidian/status/24/nm-* $out/share/icons/WhiteSur-dark/status/24/
		cp -r --no-preserve=mode ${pkgs.iconpack-obsidian}/share/icons/Obsidian/status/ $out/share/icons/WhiteSur-dark/
		
		gtk-update-icon-cache $out/share/icons/WhiteSur-dark
	'';


}
