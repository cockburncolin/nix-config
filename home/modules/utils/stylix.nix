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
    gtk ={
      enable = true;
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      # icons weren't working when declared through stylix
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
    };

    stylix = {
      enable = true;
      # images and themes must be set here as well as system wide inheritance doesn't seem to carry
      # both over
      image = ../../../resources/wallpapers/${config.${moduleBase}.${moduleName}.wallpaper};
      base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    };
  };
}
