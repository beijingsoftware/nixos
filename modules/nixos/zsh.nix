{ config, lib, pkgs, ... }:

with lib; let cfg = config.zsh;
in {

	options.zsh = {
		enable = mkEnableOption "Enable ZSH Shell";
	};

	config = mkIf cfg.enable {
		programs.zsh = {
			enable = true;
			enableCompletion = true;
			autosuggestions.enable = true;
			syntaxHighlighting.enable = true;
			oh-my-zsh = {
				enable = true;
				plugins = [ "git" ];
				theme = "pure";
			};
		};
	};

}
