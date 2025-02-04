pkgs: {
  bash-hello = import ./bash-hello.nix { inherit pkgs; };
  slstatus = import ./slstatus.nix { inherit pkgs; };
  dmenu-output = import ./dmenu-output.nix { inherit pkgs; };
}
