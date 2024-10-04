{ config, lib, pkgs, ... }:

with lib; let cfg = config.kitty;
in {
	options.kitty = {
		      enable = mkEnableOption "Enables Kitty Config";
		      fontSize = mkOption {
		      	       type = types.int;
			       default = 12;
		      };
	};

	config = mkIf cfg.enable {
	       programs.kitty = {
	       		      enable = true;
			      font.size = mkForce cfg.fontSize;
			      settings = {
				       scrollback_lines = 100000;
				       enable_audio_bell = false;
				       confirm_os_window_close = 0;
				       update_check_interval = 0;
			      };
			      extraConfig = ''
			      		  map ctrl+equal change_font_size all +2.0
					  map ctrl+minus change_font_size all -2.0
					  map ctrl+0 change_font_size all 0
			      '';
	       };
	};
}