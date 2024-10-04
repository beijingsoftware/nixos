{ inputs, outputs, config, lib, pkgs, ... }:

with lib; with outputs; let cfg = config.i3;
in {
	options.i3 = {
		enable = mkEnableOption "Enables i3 Config";
		mod = mkOption {
			type = types.str;
			default = "Mod4";
		};
		titlebar = mkOption {
			 type = types.bool;
			 default = false;
		};
		border = mkOption {
		       type = types.int;
		       default = 3;
		};
		gaps = mkOption {
		     type = types.int;
		     default = 5;
		};
		terminal = mkOption {
			 type = types.str;
			 default = "${pkgs.alacritty}/bin/alacritty";
		};
		dmenu = mkOption {
		      type = types.str;
		      default = "${pkgs.dmenu-output}/bin/dmenu-output";
		};
		screenshot = mkOption {
			   type = types.str;
			   default = "${pkgs.xfce.xfce4-screenshooter}/bin/xfce4-screenshooter -r";
		};
		startup = mkOption {
			type = types.listOf types.anything;
			default = [];
		};
		font = mkOption {
		     type = types.str;
		     default = "";
		};
		floatingCriteria = mkOption {
			type = types.listOf types.anything;
			default = [];
		};

	};


	config = mkIf cfg.enable {
		#  home.file.".xinitrc".text = ''
		#  	XDG_SESSION_DESKTOP=i3
		# 	XDG_CURRENT_DESKTOP=i3
		#  	DESKTOP_SESSION=i3
		#  	XDG_SESSION_TYPE=x11
		#  	exec i3
		#  '';
		xsession.windowManager.i3 = {
			enable = true;
			package = pkgs.i3;
			config = {
				defaultWorkspace = "workspace 1";
				floating.modifier = cfg.mod;
				window = {
					titlebar = cfg.titlebar;
					border = cfg.border;
				};
				gaps = {
					inner = cfg.gaps;
					outer = cfg.gaps;
				};
				fonts = {
					names = [ cfg.font ];
					style = "Bold";
				};
				keybindings = {
					"Mod1+Tab" = "focus right";
					"XF86AudioRaiseVolume" = "exec --no-startup-id ${custompkgs.notify-volume}/bin/notify-volume";
					"XF86AudioLowerVolume" = "exec --no-startup-id ${custompkgs.notify-volume}/bin/notify-volume";
					"XF86AudioMute" = "exec --no-startup-id ${custompkgs.notify-volume}/bin/notify-volume";
					"XF86MonBrightnessUp" = "exec --no-startup-id ${custompkgs.notify-brightness}/bin/notify-brightness";
					"XF86MonBrightnessDown" = "exec --no-startup-id ${custompkgs.notify-brightness}/bin/notify-brightness";

					"${cfg.mod}+Return" = "exec --no-startup-id ${cfg.terminal}";
					"${cfg.mod}+Shift+q" = "kill";
					"${cfg.mod}+d" = "exec --no-startup-id ${cfg.dmenu}";
					"${cfg.mod}+a" = "focus left";
					"${cfg.mod}+e" = "focus right";
					"${cfg.mod}+p" = "focus up";
					"${cfg.mod}+n" = "focus down";
					"${cfg.mod}+Shift+a" = "move left";
					"${cfg.mod}+Shift+e" = "move right";
					"${cfg.mod}+Shift+p" = "move up";
					"${cfg.mod}+Shift+n" = "move down";
					"${cfg.mod}+h" = "split h";
					"${cfg.mod}+v" = "split v";
					"${cfg.mod}+f" = "fullscreen toggle";
					"${cfg.mod}+space" = "floating toggle";

					"${cfg.mod}+Shift+r" = "restart";

					"${cfg.mod}+1" = "workspace 1";
					"${cfg.mod}+2" = "workspace 2";
					"${cfg.mod}+3" = "workspace 3";
					"${cfg.mod}+4" = "workspace 4";
					"${cfg.mod}+5" = "workspace 5";
					"${cfg.mod}+6" = "workspace 6";
					"${cfg.mod}+7" = "workspace 7";
					"${cfg.mod}+8" = "workspace 8";
					"${cfg.mod}+9" = "workspace 9";
					"${cfg.mod}+0" = "workspace 0";

					"${cfg.mod}+Shift+1" = "move container to workspace 1";
					"${cfg.mod}+Shift+2" = "move container to workspace 2";
					"${cfg.mod}+Shift+3" = "move container to workspace 3";
					"${cfg.mod}+Shift+4" = "move container to workspace 4";
					"${cfg.mod}+Shift+5" = "move container to workspace 5";
					"${cfg.mod}+Shift+6" = "move container to workspace 6";
					"${cfg.mod}+Shift+7" = "move container to workspace 7";
					"${cfg.mod}+Shift+8" = "move container to workspace 8";
					"${cfg.mod}+Shift+9" = "move container to workspace 9";
					"${cfg.mod}+Shift+0" = "move container to workspace 0";

					"Print" = "exec --no-startup-id ${cfg.screenshot}";
				};
				startup = cfg.startup;
				bars = [];
				floating.criteria = cfg.floatingCriteria;
			};
		};

	};
}
