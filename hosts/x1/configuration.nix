{ inputs, outputs, config, pkgs, lib, ... }:

with outputs; {
	imports = [
		./hardware-configuration.nix
		../../modules/nixos
	];

	networking = {
		hostName = "X1";
		networkmanager.enable = true;
	};

	users.users."user" = {
		isNormalUser = true;
		extraGroups = [ "wheel" "network" "video" "audio" "cdrom" "usb" "docker" ];
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs outputs; };
		users.user = import ./home.nix;
	};

	# System Options
	programs.light.enable = true;
	
	services.printing.enable = true;
	
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;
	
	programs.dconf.enable = true;

	# System Modules
	grub.enable = true;
	grub.theme = "${custompkgs.distro-grub-themes}";
	
	tty.enable = true;
	power.enable = true;
	power.powerManagement = true;
	
	audio.enable = true;
	
	xserver.enable = true;
	xserver.keyboardOptions = "ctrl:nocaps";

	hotkey.enable = true;
	hotkey.playPauseKey = "BOOKMARKS";

	fonts.packages = with pkgs; [ nerdfonts ];
	doas.enable = true;
	thunar.enable = true;
	fish.enable = true;

	emacs.enable = true;

	virtualisation.docker.rootless = {
		enable = true;
		setSocketVariable = true;
	};

	theme = {
	      enable = true;
	      wallpaper = ../../wallpaper.jpg;
	      darkTheme = true;
	      base16Yaml = "${pkgs.base16-schemes}/share/themes/black-metal-dark-funeral.yaml";
	      font = {
	      	   pkg = pkgs.nerdfonts;
		   name = "MartianMono Nerd Font Mono";
		   size = 8;
	      };
	      cursor = {
	      	     pkg = pkgs.whitesur-cursors;
		     name = "WhiteSur-cursors";
	      };
	};

	dwm.enable = true;

	system.stateVersion = "23.05";
}
