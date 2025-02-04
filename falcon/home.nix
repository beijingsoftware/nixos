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
    fade = true;
    shadow = true;
    blur = true;
    cornerRadius = 5;
    fadeExclude = [
      "class_g = 'dmenu'"
    ];
    opacityRule = [
      "85:class_i = 'st-256color'"
      "85:class_i = 'emacs'"
    ];
    cornerExclude = [
      "class_g = 'dwm'"
      "class_g = 'dmenu'"
    ];
    shadowExclude = [
      "class_g = 'dmenu'"
    ];
  };

  programs.git = {
    enable = true;
    userName = "beijingsoftware";
    userEmail = "coltonbreynolds@gmail.com";
    
  };

  programs.emacs.enable = true;
  stylix.targets.emacs.enable = false;

  home.packages = with pkgs; [
    wget
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

    dunst
    libnotify

    custompkgs.bash-hello
    custompkgs.slstatus
    custompkgs.dmenu-output
  ];

  dunst = {
    enable = true;
	  width = 500;
	  height = 500;
	  position = "top";
	  transparency = 30;
  };

  home.file.".xinitrc".text = ''
                                while true; do
                                    ~/.startup.sh &
                                    dwm
                                done
  '';

  home.file.".startup.sh"= {
    text = ''
                               killall -q feh picom slstatus dunst

                               feh --bg-scale ~/nixos/falcon/wallpaper.jpg &
                               picom &
                               slstatus &
                               dunst &
  '';
    executable = true;
  };
}
