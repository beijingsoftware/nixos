{ config, lib, pkgs, ... }:

with lib; let cfg = config.dwm;
in {
   options.dwm = {
   	       enable = mkEnableOption "Enables DWM Config";

   };

   config = mkIf cfg.enable {
   	  services.xserver.windowManager.dwm = {
	  	enable = true;
		package = pkgs.dwm.overrideAttrs {
			src = ./dwm;
		};
	  };
   };
}
