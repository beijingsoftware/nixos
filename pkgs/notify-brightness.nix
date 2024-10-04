{ pkgs }:

pkgs.writeShellScriptBin "notify-brightness" ''
	notificationId=54321
	msgTag="Brightness"

	brightness=$(${pkgs.light}/bin/light)

	${pkgs.dunst}/bin/dunstify -r $notificationId -a "Brightness: $brightness" -u low -i "xfpm-brightness-lcd" -h int:value:$brightness "Brightness: $brightness%"
''
