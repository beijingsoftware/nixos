{ config, lib, pkgs, ... }:

with lib; let cfg = config.thunar;
in {
   options.thunar = {
   		  enable = mkEnableOption "Enables Thunar Config";
   };

   config = mkIf cfg.enable {
  	programs.file-roller.enable = true;
	programs.thunar.enable = true;
	programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
	programs.xfconf.enable = true;
	services.gvfs.enable = true;
	services.tumbler.enable = true;
   };
}