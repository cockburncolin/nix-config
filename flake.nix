{
	description = "Colin's user dotfiles and general NixOS configurations";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
	let
		# Default arch
		system = "x86_64-linux";
	in
	{
		nixosConfigurations = {
			desktop = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ ./systems/hosts/desktop/config.nix ];
			};

			laptop = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [ ./systems/hosts/laptop/config.nix ];
			};
		};

		homeConfigurations = {
			default = home-manager.lib.homeManagerConfiguration {
				specialArgs = {inherit inputs;};
				modules = [ ./home/home.nix ];
			};
		};
	};
}
