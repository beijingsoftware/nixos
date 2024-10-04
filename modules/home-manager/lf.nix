{ config, lib, pkgs, ... }:

with lib; let cfg = config.lf;
in {
	options.lf = {
		   enable = mkEnableOption "Enables LF Config";
	};

	config = mkIf cfg.enable {
	# icons --> nix run nixpkgs#wget -- "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example" -O lf/icons
	       xdg.configFile."lf/icons".source = ./lf/icons;
	
	       programs.lf = {
	       		   enable = true;

			   settings = {
			   	    preview = true;
				    hidden = true;
				    drawbox = true;
				    icons = true;
				    ignorecase = true;
			   };

			   keybindings = {

			   	       "<c-p>" = "up";
				       "<c-n>" = "down";
				       "<c-e>" = "open";
				       "<c-f>" = "open";
				       "<c-b>" = "updir";
         			       "<c-a>" = "updir";
       				       "<a-w>" = "copy";
				       "<c-w>" = "cut";
				       "<c-y>" = "paste";
				       "<c-s>" = "search";
			   };

				extraConfig = 
				    let 
				      previewer = 
					pkgs.writeShellScriptBin "pv.sh" ''
					file=$1
					w=$2
					h=$3
					x=$4
					y=$5

					if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
					    ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
					    exit 1
					fi

					${pkgs.pistol}/bin/pistol "$file"
				      '';
				      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
					${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
				      '';
				    in
				    ''
				      set cleaner ${cleaner}/bin/clean.sh
				      set previewer ${previewer}/bin/pv.sh
				    '';
	       };
	};
}