{ pkgs }:

pkgs.writeShellScriptBin "dmenu-output" ''
    output=$(dmenu_run "$@")
    notify-send "$output"
''
