{
  description = "Colin's user dotfiles and general NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # anyrun = {
    #   url = "github:/anyrun-org/anyrun";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      # anyrun,
      firefox-addons,
      home-manager,
      nixpkgs,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      # anyrun-hm = anyrun.homeManagerModules.default;
      # anyrun-pkgs = anyrun.packages.${pkgs.system};
      pkgs = nixpkgs.legacyPackages.${system};
      firefox-adds = firefox-addons.packages.${system};
    in
    {
      nixosConfigurations = {
        caeser = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./systems/hosts/desktop/config.nix
            stylix.nixosModules.stylix
          ];
        };

        brutus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./systems/hosts/laptop/config.nix
            stylix.nixosModules.stylix
          ];
        };
      };

      homeConfigurations = {
        caeser = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit firefox-adds; };
          modules = [
            # anyrun-hm
            stylix.homeManagerModules.stylix
            ./home/hosts/desktop.nix
          ];
        };

        brutus = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit firefox-adds; };
          modules = [
            # anyrun-hm
            stylix.homeManagerModules.stylix
            ./home/hosts/laptop.nix
          ];
        };
      };
    };
}
