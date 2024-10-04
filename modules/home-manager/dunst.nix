{ config, lib, pkgs, ... }:

with lib; let cfg = config.dunst;
in {

	options.dunst = {
		      enable = mkEnableOption "Enables Dunst Config";
		      width = mkOption {
		      	    type = types.int;
			    default = 350;
		      };
		      height = mkOption {
		      	     type = types.int;
			     default = 350;
		      };
		      position = mkOption {
		      	       type = types.str;
			       default = "top";
		      };
		      transparency = mkOption {
		      		   type = types.int;
				   default = 30;
		      };
	};

	config = mkIf cfg.enable {
		services.dunst = {
			enable = true;
			settings = {
				 global = {
					width = cfg.width;
					height = cfg.height;
					origin = cfg.position;
					transparency = cfg.transparency;
					history = true;
					clickable = true;
					progress_bar = true;
					progress_bar_height = 20;
					progress_bar_frame_width = 1;
					progress_bar_min_width = 150;
					progress_bar_max_width = 350;
				};
			};
		};     
	};
}
