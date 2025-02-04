{ config, lib, pkgs, ... }:

with lib;
let cfg = config.picom;
in {
	options.picom = {
		enable = mkEnableOption "Enables Picom Config";

		fade = mkOption {
		  type = types.bool;
			default = true;
		};

		shadow = mkOption {
		  type = types.bool;
			default = true;
		};

		blur = mkOption {
		  type = types.bool;
			default = true;
		};

		cornerRadius = mkOption {
		  type = types.int;
			default = 5;
		};

		opacityRule = mkOption {
		  type = types.listOf types.str;
			default = [];
		};

		cornerExclude = mkOption {
		  type = types.listOf types.str;
			default = [];
		};

		blurExclude = mkOption {
		  type = types.listOf types.str;
			default = [];
		};

		shadowExclude = mkOption {
		  type = types.listOf types.str;
			default = [];
		};

    fadeExclude = mkOption {
      type = types.listOf types.str;
      default = [];
    };
	};

	config = mkIf cfg.enable {
	  services.picom = {
			enable = true;
			backend = "glx";
			vSync = true;
			fade = cfg.fade;
			fadeDelta = 10;
			shadow = cfg.shadow;
			shadowOpacity = 1;
			settings = {
				use-damage = true;
				unredir-if-possible = true;
				blur = {
					method = if cfg.blur then "dual_kawase" else "none";
					size = 10;
					deviation = 5.0;
          #					strength = 5;
				};
				opacity-rule = cfg.opacityRule;
				corner-radius = cfg.cornerRadius;
				round-borders = 1;
        fade-exclude = cfg.fadeExclude;
				rounded-corners-exclude = cfg.cornerExclude;
				blur-background-exclude = cfg.blurExclude;
				shadow-exclude = cfg.shadowExclude;
			};
		};	       
	};
}
