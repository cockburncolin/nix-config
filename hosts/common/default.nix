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
    sops-nix.nixosModules.sops
  ];

  config = {
    custom = {
      user.enable = lib.mkDefault true;
      uefi.enable = lib.mkDefault true;
    };

    sops = {
      age = {
        sshKeyPaths = ["/home/${config.custom.user.username}/.ssh/id_ed25519"];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };

      defaultSopsFile = ../../secrets/secrets.yaml;
      secrets."users/rootpw".neededForUsers = true;
    };

    users.users.root.hashedPasswordFile = config.sops.secrets."users/rootpw".path;
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
