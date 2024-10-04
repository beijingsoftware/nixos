pkgs:
{
	bash-hello = import ./bash-hello.nix { inherit pkgs; };
	custom-icons = import ./custom-icons.nix { inherit pkgs; };
	distro-grub-themes = import ./distro-grub-themes.nix { inherit pkgs; };
	cairo-dock = import ./cairo-dock.nix { inherit pkgs; };
	polydock = import ./polydock.nix { inherit pkgs; };
	notify-volume = import ./notify-volume.nix { inherit pkgs; };
	notify-brightness = import ./notify-brightness.nix { inherit pkgs; };
	nixver = import ./nixver.nix { inherit pkgs; };
	dmenu-output = import ./dmenu-output.nix { inherit pkgs; };
	rofi-themes = import ./rofi-themes.nix { inherit pkgs; };
}

# {
# 	imports = [
# 		./bash-hello.nix
# 		./custom-icons.nix
# 		./distro-grub-themes.nix
# 		./cairo-dock.nix
# 		./polydock.nix
# 		./notify-volume.nix
# 		./notify-brightness.nix
# 		./nixver.nix
# 		./dmenu-output.nix
# 		./rofi-themes.nix
# 	];
# }