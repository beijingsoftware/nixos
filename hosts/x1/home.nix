{ inputs, outputs, config, pkgs, ... }:

with outputs; {
     imports = [
     	     ../../modules/home-manager
     ];

     home = {
     	  username = "user";
	  homeDirectory = "/home/user";
	  stateVersion = "24.05";
     };


     # Theme
     stylix.targets.rofi.enable = false;
     qt.platformTheme = "gtk2";
     gtk.enable = true;
     gtk.iconTheme = {
     		   package = custompkgs.custom-icons;
		   name = "WhiteSur-dark";
     };

     # Home Manager Config
     programs.home-manager.enable = true;
     
     services.blueman-applet.enable = true;

     # Home Manager Modules
     apps.enable = true;
     dunst = {
     	   enable = true;
	   width = 350;
	   height = 350;
	   position = "top";
	   transparency = 30;
     };

     i3 = {
     	       enable = true;
	       mod = "Mod4";
	       titlebar = false;
	       border = 3;
	       gaps = 5;
	       terminal = "${pkgs.kitty}/bin/kitty";
	       dmenu = "${custompkgs.dmenu-output}/bin/dmenu-output";
	       screenshot = "${pkgs.xfce.xfce4-screenshooter}/bin/xfce4-screenshooter";
	       font = "MartianMono Nerd Font Mono";
	       	startup = [
		{ command = "killall -q polybar; sleep 0.5 && polybar top"; always = true; notification = false;}
		{ command = "nm-applet"; always = true; notification = false;}
		{ command = "feh --bg-scale ~/nixos/wallpaper.jpg"; always = true; notification = false; }
		{ command = "killall -q picom; sleep 0.5 && picom"; always = true; notification = false; }
		{ command = "xset s off -dpms"; always = true; notification = false; }
		{ command = "dunst"; always = true; notification = false; }
#		{ command = "plank"; always = true; notification = false; }
		{ command = "webcord -m"; always = true; notification = false; } 
	];
	floatingCriteria = [
		{ class = "file-roller"; }
		{ workspace = "0"; }
	];
     };

     nyxt.enable = true;
     
     picom = {
     	   enable = true;
	   fade = true;
	   shadow = true;
	   blur = true;
	   cornerRadius = 5;
	   opacityRule = [
	   	   "85:class_g = 'kitty'"
	   	   "85:class_g = 'Alacritty'"
		   "85:class_g = 'i3'"
		   "85:class_g = 'Thunar'"
		   "70:class_g = 'dmenu'"
		   "90:class_g = 'WebCord'"
	    ];
	   cornerExclude = [
	   	   "class_g = 'Polybar'"
		   "class_g = 'dmenu'"
		   "class_g ?= 'plank'"
	   ];
	   blurExclude = [
	   	   "class_g ?= 'xfce4-screenshooter'"
		   "class_g ?= 'plank'"
	   ];
	   shadowExclude = [
	   	   "class_g ?= 'plank'"				
	   ];
     };

     plank = {
     	   enable = true;
	   iconSize = 50;
	   theme = "Nix OS";
	   dockItems = [
	   	   "finder.dockitem"
		   "terminal.dockitem"
		   "nyxt.dockitem"
		   "emacs.dockitem"
		   "thunderbird.dockitem"
		   "webcord.dockitem"
		   "blender.dockitem"
		   "preview.dockitem"
		   "vlc.dockitem"
		   "screenshot.dockitem"
		   "trashcan.dockitem"
	   ];
     };
     
     polybar = {
     	     enable = true;
	     monitor = "eDP-1";
	     modulesLeft = "logo xworkspaces";
	     modulesCenter = "";
	     modulesRight = "tray spotlight mic volume battery date";
     };

     rofi.enable = true;

     programs.mpv = {
     		  enable = true;
		  scripts = [ pkgs.mpvScripts.mpris ];
     };

     kitty.enable = true;
     lf.enable = true;

     home.packages = with pkgs; [
     		   wget
		   git
		   tree
		   unzip
		   killall
		   pulsemixer
		   pavucontrol
		   arandr
		   lxappearance
		   libnotify
		   networkmanagerapplet
		   
		   feh
		   dmenu
		   xfce.xfce4-screenshooter
		   vlc
		   discordo
		   webcord
		   thunderbird
		   firefox
		   ranger
		   nomacs
		   screenfetch
		   neofetch
		   tty-clock
		   neo
		   btop
		   blender
		   ytfzf
		   yewtube
		   ffmpeg
		   tdf
		   sioyek
		   okular
		   vscodium
		   docker-compose

		   custompkgs.dmenu-output
		   custompkgs.nixver
		   custompkgs.notify-brightness
		   custompkgs.notify-volume
		   custompkgs.bash-hello
     ];

     home.file.".config/sioyek/keys_user.config".text = ''
     	goto_begining <A-<>
	goto_end      <A->>
     '';
}
