{ config, lib, pkgs, ... }:

with lib; let cfg = config.doas;
in {
	options.doas = {
		enable = mkEnableOption "Enables Doas Config";
	};

	config = mkIf cfg.enable {
		security.doas.enable = true;
		security.sudo.enable = false;
		security.doas.extraRules = [{
			users = [ "user" ];
			keepEnv = true;
			persist = true;
		}];
	};
}
