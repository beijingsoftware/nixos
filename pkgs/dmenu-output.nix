{ pkgs }:

pkgs.writeShellScriptBin "dmenu-output" ''
	output=$(dmenu_run -b -i -nb '#000' -sb '#fff' -sf '#000' -fn 'MartianMono Nerd Font Mono')
	notify-send "$output"
''
