{ config, outputs, lib, pkgs, ... }:

with lib; with outputs;
let cfg = config.rofi;
in {

	options.rofi = {
		     enable = mkEnableOption "Enables Rofi Config";
	};

	config = mkIf cfg.enable {
		home.packages = with pkgs; [
			custompkgs.rofi-themes
		];
		programs.rofi = {
			enable = true;
			location = "top-right";
			theme = "spotlight-dark";
			cycle = true;
			terminal = "${pkgs.alacritty}/bin/alacritty";
			plugins = with pkgs; [
				rofimoji
				rofi-vpn
				rofi-top
				rofi-mpd
				rofi-calc
				rofi-systemd
				rofi-bluetooth
				rofi-screenshot
				rofi-power-menu
				rofi-pulse-select
				rofi-file-browser
			];
		};	
	};
}
