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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    alejandra,
    anyrun,
    home-manager,
    nixpkgs,
    firefox-addons,
    ...
  } @ inputs: let
    # Default arch
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    firefox-adds = firefox-addons.packages.${system};
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

    homeConfigurations.desktop = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit firefox-adds;};
      modules = [./home/home.nix];
    };
  };
}
