{ pkgs, lib, ... }: {

        imports = [
		./grub.nix
                ./nvidia.nix
                ./xserver.nix
		./audio.nix
		./tty.nix
		./gnome.nix
		./doas.nix
		./hotkey.nix
		./fish.nix
		./theme.nix
		./zsh.nix
		./power.nix
		./thunar.nix
		./emacs.nix
		./dwm.nix
        ];

	time.timeZone = "America/Los_Angeles";
	time.hardwareClockInLocalTime = true;
	i18n.defaultLocale = "en_US.UTF-8";
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
