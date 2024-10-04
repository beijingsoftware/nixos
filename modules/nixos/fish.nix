{ config, lib, pkgs, ... }:

with lib; let cfg = config.fish;
in {

	options.fish = {
		enable = mkEnableOption "Enables Fish Shell";
	};

	config = mkIf cfg.enable {

		programs.fish = {
			enable = true;
			interactiveShellInit = ''
				set fish_greeting
			'';
		};

		
		environment.systemPackages = with pkgs; [
			fishPlugins.sponge
			fishPlugins.pure
		];

		programs.bash = {
			interactiveShellInit = ''
				if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
				then
					shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
					exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
				fi
			'';
		};	
	};

}
