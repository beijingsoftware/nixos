{

	description = "System Configuration Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows="nixpkgs";
		};
		stylix.url = "github:danth/stylix";
	};

	outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
	let inherit (self) outputs; in {

		custompkgs = import ./pkgs nixpkgs.legacyPackages.x86_64-linux;
		
		nixosConfigurations = {
			X1 = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs outputs; };
				modules = [
					./hosts/x1/configuration.nix
					home-manager.nixosModules.home-manager
					inputs.stylix.nixosModules.stylix
				];
			};

			nixos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs outputs; };
				modules = [
					./hosts/nixos/configuration.nix
					home-manager.nixosModules.default
					inputs.stylix.nixosModules.stylix
				];
			};
		};

	};
}
	
