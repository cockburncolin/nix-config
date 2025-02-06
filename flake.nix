{
  description = "Colin's user dotfiles and general NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

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

<<<<<<< HEAD
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
      modules = [./home/hosts/desktop.nix];
    };

    homeConfigurations.laptop = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit firefox-adds;};
      modules = [./home/hosts/laptop.nix];
=======
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
>>>>>>> anyrun
    };
  };

  outputs =
    {
      self,
      anyrun,
      firefox-addons,
      home-manager,
      nixpkgs,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      anyrun-hm = anyrun.homeManagerModules.default;
      anyrun-pkgs = anyrun.packages.${pkgs.system};
      pkgs = nixpkgs.legacyPackages.${system};
      firefox-adds = firefox-addons.packages.${system};
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./systems/hosts/desktop/config.nix ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./systems/hosts/laptop/config.nix ];
        };
      };

      homeConfigurations.desktop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit anyrun-pkgs firefox-adds; };
        modules = [
          anyrun-hm
          ./home/home.nix
        ];
      };
    };
}
