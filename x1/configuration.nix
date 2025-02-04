{ inputs, outputs, config, pkgs, lib, ... }:

with outputs; {
  imports = [
    ./hardware-configuration.nix
    ../modules
  ];
  
  system.stateVersion = "24.11";
  
  networking = {
    hostName = "X1";
    networkmanager.enable = true;
  };

  grub.enable = true;
  tty.enable = true;
  xserver.enable = true;
  xserver.keyboardOptions = "ctrl:nocaps";
  doas.enable = true;
  
  services.printing.enable = true;

  environment.etc = {
    "resolv.conf".text = "nameserver 1.1.1.1\n";
  };

  dwm.enable = true;

  fonts.packages = [
    pkgs.nerd-fonts.martian-mono
  ];
  
  theme = {
    enable = true;
    wallpaper = ./wallpaper.jpg;
    darkTheme = true;
    base16Yaml = "${pkgs.base16-schemes}/share/themes/black-metal-dark-funeral.yaml";
    font = {
      pkg = pkgs.nerd-fonts.martian-mono;
      name = "MartianMono Nerd Font Mono";
      size = 8;
    };
    cursor = {
      pkg = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
    };
  };

  users.users."user" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "network" "video" "audio" "cdrom" "usb" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users.user = import ./home.nix;
  };
}
