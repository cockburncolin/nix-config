# Takes moduleBase from importing file
{
  moduleBase ? "misc",
}:
{
  config,
  lib,
  pkgs,
  stylix,
  ...
}:
let
  moduleName = "stylix";
in
{
  imports = [];

  options = {
    "${moduleBase}"."${moduleName}" = {
      enable = lib.mkOption {
        default = true;
        description = "enable ${moduleName}";
        type = lib.types.bool;
      };
      wallpaper = lib.mkOption {
        default = "castle.png";
        description = "filename to choose from resources/wallpapers folder";
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
    stylix = {
      enable = true;
      image = ../../../resources/wallpapers/${config.${moduleBase}.${moduleName}.wallpaper};
      base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-burzum.yaml";
    };
  };
}
