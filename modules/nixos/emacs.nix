{ config, lib, pkgs, ... }:

with lib; let
     cfg = config.emacs;
in {

   options.emacs = {
   		 enable = mkEnableOption "Enables Emacs Config";
   };

   config = mkIf cfg.enable {
   	  services.emacs = {
	  		 enable = true;
			 package = pkgs.emacs-gtk;
	  };

	  environment.systemPackages = with pkgs; let
	  	my-python-packages = python-packages: with python-packages; [
			pandas
			requests
			sexpdata tld
			pyqt6 pyqt6-sip
			pyqt6-webengine epc lxml
			qrcode
			pysocks
			pypinyin
			psutil
			retry
			markdown					
		];
		python-with-my-packages = python3.withPackages my-python-packages;
	  in [
	  		emacs-all-the-icons-fonts

			git
			nodejs
			wmctrl
			xdotool
			aria
			fd

			python-with-my-packages
	  ];

	  environment.variables = {
	  	QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt6.qtbase.outPath}/lib/qt-6/plugins";
	  };
   };
}
