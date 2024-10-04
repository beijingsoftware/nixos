{ config, lib, pkgs, ... }:

with lib; let cfg = config.xserver;
in {
	options.xserver = {
		enable = mkEnableOption "Enables Xserver Config";

		keyboardOptions = mkOption {
			type = types.str;
			default = "";
		};
	};

	config = mkIf cfg.enable {
		services.xserver = {
			enable = true;
			xkb.layout = "us";
			xkb.options = cfg.keyboardOptions;
			displayManager.startx.enable = true;
		};
	};

	
}
