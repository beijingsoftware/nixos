{ pkgs }:

pkgs.writeShellScriptBin "notify-volume" ''
	notificationId=12345
	msgTag="Volume"

	volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
	mute=$(${pkgs.pamixer}/bin/pamixer --get-mute)

	if [[ $mute == "true" ]]; then
		message="Volume: $volume% [Muted]"
		icon="audio-volume-muted"
	else
		message="Volume: $volume%"
		icon="audio-volume-high"
	fi
	
	${pkgs.dunst}/bin/dunstify -r $notificationId -a "$msgTag" -u low -i "$icon" -h int:value:$volume "$message"
''
