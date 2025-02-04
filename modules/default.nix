{ pkgs, lib, ... }: {

  imports = [
    ./grub.nix
    ./nvidia.nix
    ./xserver.nix
    ./tty.nix
    ./doas.nix
    ./power.nix
    ./audio.nix
    ./dwm.nix
    ./theme.nix
  ];

	time.timeZone = "America/Los_Angeles";
	time.hardwareClockInLocalTime = true;
	i18n.defaultLocale = "en_US.UTF-8";
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
