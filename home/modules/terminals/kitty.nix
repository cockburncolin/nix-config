{moduleBase ? "misc"}: {
  config,
  pkgs,
  lib,
  ...
}: let
  moduleName = "kitty";
in {
  imports = [];

  options = {
    ${moduleBase}.${moduleName}.enable = lib.mkOption {
      default = true;
      description = "enable ${moduleName}";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.${moduleBase}.${moduleName}.enable {
    programs.kitty = {
      enable = true;
      settings = {
        window_margin_width = 2;
        window_padding_width = 10;
      };
    };
  };
}
