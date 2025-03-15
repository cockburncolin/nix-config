{
  moduleBase ? "misc",
}:
{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  moduleName = "makeUser";
in
{
  imports = [ ];
  options = {
    "${moduleBase}"."${moduleName}" = {
      enable = lib.mkOption {
        default = true;
        description = "enable ${moduleName}";
        type = lib.types.bool;
      };

      userName = lib.mkOption {
        default = "colin";
        description = "username for regular user";
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config.${moduleBase}.${moduleName}.enable {
    programs.fish.enable = true;
    users.users."${config.${moduleBase}.${moduleName}.userName}" = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$P0yrCluAkpRNQHuYv6qSW/$7m8zz7hzt4nm70591yJ2uB6Il05k6uRGu9R1kfFq092";
      description = "Colin Cockburn";
      extraGroups = [
        "audio"
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
    };
  };
}
