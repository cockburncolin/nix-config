{
  description = "Colin's user dotfiles and general NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:/anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    anyrun,
    ...
  } @ inputs: let
    # Default arch
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./systems/hosts/desktop/config.nix];
      };

      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./systems/hosts/laptop/config.nix];
      };
    };

    homeConfigurations.colin = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home/home.nix];
    };
  };
}
