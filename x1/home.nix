{ inputs, outputs, config, pkgs, ... }:

with outputs; {
  imports = [
    ../home-manager
  ];

  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  picom = {
    enable = true;
    fade = false;
    shadow = false;
    blur = false;
    cornerRadius = 0;
  };

  programs.emacs.enable = true;

  home.packages = with pkgs; [
    wget
    git
    tree
    unzip
    killall
    pulsemixer
    pavucontrol

    feh
    firefox
    neo
    btop
    
    dmenu
    st

    custompkgs.bash-hello
  ];
}
