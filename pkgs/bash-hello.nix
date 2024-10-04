{ pkgs }:

pkgs.stdenv.mkDerivation {
	pname = "bash-hello";
	version = "1.0";
	
	src = null;
	
	buildInputs = [ pkgs.bash ];

	phases = [ "installPhase" ];
	
	installPhase = ''
		mkdir -p $out/bin
		echo '#!/usr/bin/env bash' > $out/bin/hello
		echo 'echo "Hello, NixOS!"' >> $out/bin/hello
		chmod +x $out/bin/hello
	'';
}
