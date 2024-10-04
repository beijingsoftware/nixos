{ inputs, outputs, config, pkgs, lib, ... }:

with outputs; {
	imports = [
		./hardware-configuration.nix
		../../modules/nixos
	];

	networking = {
		hostName = "nixos";
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
	services.printing.enable = true;

	hardware.bluetooth.enable = true;
	services.blueman.enable = true;

	programs.dconf.enable = true;

	# System Modules
	grub.enable = true;
	grub.theme = "${custompkgs.distro-grub-themes}";

	nvidia.enable = true;
	tty.enable = true;
	power.enable = true;

	audio.enable = true;

	xserver.enable = true;

	hotkey.enable = true;
	
	fonts.packages = with pkgs; [ nerdfonts ];
	doas.enable = true;
	thunar.enable = true;
	fish.enable = true;

	emacs.enable = true;

	theme = {
	      enable = true;
	      wallpaper = ../../wallpaper.jpg;
	      darkTheme = true;
	      base16Yaml = "${pkgs.base16-schemes}/share/themes/black-metal-dark-funeral.yaml";
	      font = {
	      	   pkg = pkgs.nerdfonts;
		   name = "MartianMono Nerd Font Mono";
		   size = 20;
	      };
	      cursor = {
	      	     pkg = pkgs.whitesur-cursors;
		     name = "WhiteSur-cursors";
	      };
	};

	system.stateVersion = "23.05";
}
