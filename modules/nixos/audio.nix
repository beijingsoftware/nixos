{ config, lib, pkgs, ... }:

with lib; let cfg = config.audio;
in {

	options.audio = {
		enable = mkEnableOption "Enables Sound Config";
	};

	config = mkIf cfg.enable {
		security.rtkit.enable = true;
		hardware.pulseaudio.enable = false;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			pulse.enable = true;
		};
	};
}
