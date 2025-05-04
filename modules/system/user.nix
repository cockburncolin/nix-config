{
  lib,
  inputs,
  pkgs,
  config,
  ...
}: let
  cfg = config.custom.user;
in {
  # module options
  options.custom.user = {
    enable = lib.mkEnableOption "Create system non root user";

    username = lib.mkOption {
      default = "colin";
      description = "Name of the system user";
      example = "foo";
      type = lib.types.str;
    };

    additionalGroups = lib.mkOption {
      default = [];
      description = "List of additional groups to add to the group";
      example = lib.literalString [
        "docker"
        "networkmanager"
      ];
      type = lib.types.listOf lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.userpw.neededForUsers = true;

    # shells/other user programs to install
    environment.systemPackages = with pkgs; [
      alejandra
      fd
      fzf
      gcc
      git
      kitty
      neovim
      nushell
      ranger
      ripgrep
      sops
      ssh-to-age
      starship
      stow
      tree
      unzip
      zoxide
    ];

    users.mutableUsers = false;

    users.users.${cfg.username} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.userpw.path;
      extraGroups = ["wheel"] ++ cfg.additionalGroups;
      shell = pkgs.nushell;
    };
  };
}
