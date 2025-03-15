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
  imports = [ ];

  options = {
    "${moduleBase}"."${moduleName}" = {
      enable = lib.mkOption {
        default = true;
        description = "enable ${moduleName}";
        type = lib.types.bool;
      };

      theme = lib.mkOption {
        default = "onedark";
        description = "base 16 theme to use";
        type = lib.types.str;
      };

      wallpaper = lib.mkOption {
        default = "mountains.png";
        description = "filename to choose from resources/wallpapers folder";
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
    # icons weren't working when declared through stylix
    gtk.iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    stylix = {
      enable = true;
      # images and themes must be set here as well as system wide inheritance doesn't seem to carry
      # both over
      image = ../../../resources/wallpapers/${config.${moduleBase}.${moduleName}.wallpaper};
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${
        config.${moduleBase}.${moduleName}.theme
      }.yaml";
      cursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 22;
      };

      targets = {
        waybar.enable = false;
        firefox.profileNames = [ "default" ];
      };
    };
  };
}
