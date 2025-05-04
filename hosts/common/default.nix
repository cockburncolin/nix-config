# common configuration for all hosts
{
  lib,
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = with inputs; [
    ../../modules
    disko.nixosModules.disko
    agenix.nixosModules.default
  ];

  config = {
    custom = {
      uefi.enable = lib.mkDefault true;
      user.enable = lib.mkDefault true;
    };

    age.secrets.rootpw.file = ../../secrets/rootpw.age;
    users.users.root.hashedPasswordFile = config.age.secrets.rootpw.path;

    # default fonts to install
    fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

    # default system wide packages to install
    environment.systemPackages = with pkgs; [cmake clang-tools];

    nixpkgs = {
      overlays = with outputs.overlays; [
        additions
        modifications
        stable-packages
      ];

      config = {
        allowUnfree = true;
      };
    };

    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        trusted-users = [
          "root"
          config.custom.user.username
        ];
      };
      optimise.automatic = true;
      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
    };
  };
}
