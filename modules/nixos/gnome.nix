{ config, lib, pkgs, ... }:

with lib; let cfg = config.gnome;
in {
	options.gnome = {
		enable = mkEnableOption "Enables Gnome Desktop";
		gdm = mkOption {
			type = types.bool;
			default = true;
		};
	};

	config = mkIf cfg.enable {
		services.xserver.desktopManager.gnome.enable = true;
		services.xserver.displayManager.gdm.enable = cfg.gdm;
	};

}
