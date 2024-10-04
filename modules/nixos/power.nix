{ config, lib, pkgs, ... }:

with lib; let cfg = config.power;
in {

   options.power = {
   		 enable = mkEnableOption "Enable Power";

		 powerManagement = mkOption {
		 		 type = types.bool;
				 default = false;
		 };
   };

   config = mkIf cfg.enable {
   	  services.logind = {
	  		  lidSwitch = "hibernate";
			  lidSwitchDocked = "ignore";
			  lidSwitchExternalPower = "ignore";
			  extraConfig = ''
			  	      IdleAction=lock
				      IdleActionSec=0
			  '';
	  };

	  services.tlp.enable = cfg.powerManagement;
   };
}