# common configuration for all hosts
{
  lib,
  config,
  inputs,
  outputs,
  ...
}:
{
  imports = with inputs; [
    ../../modules
    agenix.nixosModules.default
    disko.nixosModules.disko
  ];

  config = {
    custom.user.enable = lib.mkDefault true;
    custom.uefi.enable = lib.mkDefault true;

    age.identityPaths = [ "/home/${config.custom.user.username}/.ssh/id_ed25519" ];

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
