{ config, lib, pkgs, ... }:

with lib; let cfg = config.tty;
in {

	options.tty = {
		    enable = mkEnableOption "Enables TTY Config";
	};

	config = mkIf cfg.enable {
	       	console = {
		earlySetup = true;
		useXkbConfig = true;
		packages = with pkgs; [
			terminus_font
		];
		font = "ter-124b";
		};
		environment.etc.issue = lib.mkForce {
			source = pkgs.writeText "issue" "";
		};
	};
}
