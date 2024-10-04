{ config, lib, pkgs, ... }:

with lib; let cfg = config.nvidia;
in {
	options.nvidia = {
		enable = mkEnableOption "Enables Nvidia Config";

		settings = mkOption {
			type = types.bool;
			default = true;
			description = "Enables Nvidia Settings App";
		};
	};

	config = mkIf cfg.enable {
		hardware.graphics.enable = true;
		services.xserver.videoDrivers = [ "nvidia" ];
		hardware.nvidia = {
			open = true;
			modesetting.enable = true;
			nvidiaSettings = true;
		};
	};
}
