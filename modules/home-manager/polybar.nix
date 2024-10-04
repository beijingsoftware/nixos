{ config, lib, pkgs, ... }:

with lib; let cfg = config.polybar;
in {

	options.polybar = {
			enable = mkEnableOption "Enables Polybar Config";

			modulesLeft = mkOption {
				    type = types.str;
				    default = "logo xworkspaces";
			};

			modulesCenter = mkOption {
				      type = types.str;
				      default = "";
			};

			modulesRight = mkOption {
				     type = types.str;
				     default = "tray spotlight mic volume battery date";
			};

			monitor = mkOption {
				type = types.str;
				default = "DP-0";
			};
	};

	config = mkIf cfg.enable {
	  home.file.".config/polybar/mic-tog.sh" = {
		executable = true;
		text = ''
			#!/run/current-system/sw/bin/bash
			volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

			if [[ "$volume_info" == *"[MUTED]"* ]]; then
			  echo ""
			else
			  echo ""
			fi
		'';
	  };

	  services.polybar = {
		enable = true;
		package = pkgs.polybar.override {
			alsaSupport = true;
			githubSupport = true;
			pulseSupport = true;
			mpdSupport = true;
		};
		script = "polybar top &";
			config = {
				"bar/top" = {
					monitor = cfg.monitor;
					width = "100%";
					height = "20pt";
					radius = "0";
					background = "#B3000000";
					foreground = "#ffffff";
					underline-size = "2";
					border-color = "#00000000";
					padding-left = "1";
					padding-right = "1";
					module-margin = "1";
					modules-left = cfg.modulesLeft;
					modules-center = cfg.modulesCenter;
					modules-right = cfg.modulesRight;
					font-0 = "MartianMono Nerd Font;1";
				  };

				"module/xworkspaces" = {
					pin-workspaces = true;
					type = "internal/xworkspaces";
					label-active = "%name%";
					label-active-underline = "#ffffff";
					label-active-padding = 1;
					label-occupied = "%name%";
					label-occupied-padding = 1;
					label-urgent = "%name%";
					label-urgent-background = "#ffffff";
					label-urgent-padding = 1;
					label-empty = "%name%";
					label-empty-foreground = "#ffffff";
					label-empty-padding = 1;
				};

				"module/xwindow" = {
					type = "internal/xwindow";
					label = "%class%";
				};

				"module/logo" = {
					type = "custom/text";
					label = "";
					click-left = "notify-send \"$(nixver)\"";
				};

				"module/spotlight" = {
					type = "custom/text";
					label = "";
					click-left = "rofi -show run";
				};


				"module/mic" = {
					type = "custom/script";
					tail = true;
					interval = 0;
					exec = "/home/user/.config/polybar/mic-tog.sh &";
					click-left = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
				};


				"module/volume" = {
					type = "internal/pulseaudio";
					format-volume = "<ramp-volume>";
					ramp-volume-0 = "";
					ramp-volume-1 = "";
					ramp-volume-2 = "";
					label-muted = "";
	#				label-muted-foreground = "#66";
				};

				"module/date" = {
					type = "internal/date";
					interval = 1;
					date = "%a %b %d %l:%M %p";
					label = "%date%";
				};


				"module/battery" = {
					type = "internal/battery";
					battery = "BAT0";
					full-at = 97;
					label-full = " 100%";
					label-charging = "󱐋%percentage%%";
					label-discharging = " %percentage%%";
					poll-interval = 1;
				};

				"module/tray" = {
					type = "internal/tray";
					align = "right";
	#				spacing = 10;
					tray-spacing = 15;
				};
			};
		};	
	};

}
