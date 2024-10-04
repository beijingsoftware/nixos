{ config, lib, pkgs, ... }:

with lib; let cfg = config.grub;
in {
	options.grub = {
		     enable = mkEnableOption "Enables Grub";
		     theme = mkOption {
		     	   type = types.str;
			   default = null;
		     };
	};

	config = mkIf cfg.enable {
		boot.loader = {
			efi.canTouchEfiVariables = true;
			grub = {
				enable = true;
				devices = [ "nodev" ];
				useOSProber = true;
				efiSupport = true;
				theme = cfg.theme;
			};
		};
	};
}
