{ inputs, outputs, config, lib, pkgs, ... }:

with lib; with outputs; let
     cfg = config.hotkey;
     light = "${pkgs.light}/bin/light";
     wpctl = "${pkgs.wireplumber}/bin/wpctl";
     playerctl = "${pkgs.playerctl}/bin/playerctl";
     notify-volume = "${custompkgs.notify-volume}/bin/notify-volume";
     vars = "env HOME=/home/user XDG_CONFIG_DIRS=/etc/xdg:/home/user/.nix-profile/etc/xdg:/nix/profile/etc/xdg:/home/user/.local/state/nix/profile/etc/xdg:/etc/profiles/per-user/user/etc/xdg:/nix/var/nix/profiles/default/etc/xdg:/run/current-system/sw/etc/xdg XDG_SESSION_TYPE=tty XDG_SESSION_CLASS=user USER=user XDG_VTNR=1 XDG_SESSION_ID=1 XDG_RUNTIME_DIR=/run/user/1000 XDG_DATA_DIRS=/nix/store/0pss0v1js1x670g1xg9qd8w6yynrkm5c-desktops/share:/home/user/.nix-profile/share:/nix/profile/share:/home/user/.local/state/nix/profile/share:/etc/profiles/per-user/user/share:/nix/var/nix/profiles/default/share:/run/current-system/sw/share LIBEXEC_PATH=/home/user/.nix-profile/libexec:/nix/profile/libexec:/home/user/.local/state/nix/profile/libexec:/etc/profiles/per-user/user/libexec:/nix/var/nix/profiles/default/libexec:/run/current-system/sw/libexec DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0";
in {
   options.hotkey = {
   		  enable = mkEnableOption "Enables Hotkey";
		  brightnessIncrement = mkOption {
		  		      type = types.int;
				      default = 1;
		  };
		  volumeIncrement = mkOption {
		  		  type = types.int;
				  default = 1;
		  };
		  brightnessDownKey = mkOption { type = types.str; default = "BRIGHTNESSDOWN"; };
		  brightnessUpKey = mkOption { type = types.str; default = "BRIGHTNESSUP"; };
		  muteKey = mkOption { type = types.str; default = "MUTE"; };
		  volumeDownKey = mkOption { type = types.str; default = "VOLUMEDOWN"; };
		  volumeUpKey = mkOption { type = types.str; default = "VOLUMEUP"; };
		  micMuteKey = mkOption { type = types.str; default = "F20"; };
		  playPauseKey = mkOption { type = types.str; default = "PLAYPAUSE"; };
   };

   config = mkIf cfg.enable {
   	  services.triggerhappy = {
	  			enable = true;
				user = "user";
				bindings = [
					 {
						keys = [cfg.brightnessDownKey];
						event = "press";
						cmd = "${vars} ${light} -U 1";
					 }
					 {
						keys = [cfg.brightnessUpKey];
						event = "press";
						cmd = "${vars} ${light} -A 1";
					 }
					 {
						keys = [cfg.muteKey];
						event = "press";
						cmd = "${vars} ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
					 }
					 {
						keys = [cfg.volumeDownKey];
						event = "press";
						cmd = "${vars} ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 1%-";
					 }
					 {
						keys = [cfg.volumeDownKey];
						event = "hold";
						cmd = "${vars} ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 1%-";
					 }
					 {
						keys = [cfg.volumeUpKey];
						event = "press";
						cmd = "${vars} ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 1%+";
					 }
					 {
						keys = [cfg.volumeUpKey];
						event = "hold";
						cmd = "${vars} ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 1%+";
					 }
					 {
						keys = [cfg.micMuteKey];
						event = "press";
						cmd = "${vars} ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
					 }
					 {
						keys = [cfg.playPauseKey];
						event = "press";
						cmd = "${vars} ${playerctl} play-pause";
					 }
				];
	  };
   };
}
