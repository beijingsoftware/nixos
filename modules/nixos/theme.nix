{ config, lib, pkgs, ... }: 

with lib; let cfg = config.theme;
in {
	options.theme = {
		     enable = mkEnableOption "Enables Stylix Theme";
		     wallpaper = mkOption {
		     	       type = types.path;
			       default = ../../wallpaper.png;
		     };
		     darkTheme = mkOption {
		     	       type = types.bool;
			       default = true;
		     };
		     base16Yaml = mkOption {
		     		  type = types.str;
				  default = "${pkgs.base16-schemes}/share/themes/black-metal-dark-funeral.yaml";
		     };
		     font = mkOption {
		     	  type = types.submodule {
			    options = {
			    	    pkg = mkOption {
				    	 type = types.package;
					 default = pkgs.nerdfonts;
				    };
				    name = mkOption {
				    	 type = types.str;
					 default = "MartianMono Nerd Font Mono";
				    };
				    size = mkOption {
				    	 type = types.int;
					 default = 8;
				    };
			    };
			  };
			  default = {
			  	  pkg = pkgs.nerdfonts;
				  name = "MartianMono Nerd Font Mono";
				  size = 8;
			  };
		     };
		     cursor = mkOption {
		     	    type = types.submodule {
			    	 options = {
				 	 pkg = mkOption {
					     type = types.package;
					     default = pkgs.whitesur-cursors;
					 };
					 name = mkOption {
					      type = types.str;
					      default = "WhiteSur-cursors";
					 };
				 };
			    };
		     };
		     
	};

	config = mkIf cfg.enable {
	       stylix = {
	       	      enable = true;
		      image = cfg.wallpaper;
		      polarity = if cfg.darkTheme then "dark" else "light";
		      base16Scheme = cfg.base16Yaml;
		      fonts = {
		      	    monospace = {
			    	      package = cfg.font.pkg;
				      name = cfg.font.name;
			    };
			    serif = config.stylix.fonts.monospace;
			    sansSerif = config.stylix.fonts.monospace;
			    emoji = config.stylix.fonts.monospace;
			    sizes.applications = 8;
		      };
		      targets = {
		      	      grub.enable = false;
			      grub.useImage = false;
			      fish.enable = false;
		      };
		      cursor = {
		      	     package = cfg.cursor.pkg;
			     name = cfg.cursor.name;
		      };
	       };
	};
}
