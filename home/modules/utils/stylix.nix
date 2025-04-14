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
  theme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  wallpaper = pkgs.runCommand "image.png" { } ''
    COLOR=$(${pkgs.yq}/bin/yq -r .palette.base01 ${theme})
    ${pkgs.imagemagick}/bin/magick -size 1920x1080 xc:$COLOR $out
  '';
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
        default = "oxocarbon-dark";
        description = "base 16 theme to use";
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
      polarity = "dark";
      # images and themes must be set here as well as system wide inheritance doesn't seem to carry
      # both over
      image = wallpaper;
      base16Scheme = theme;
        cursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 22;
      };

      targets = {
        waybar.enable = false;
        emacs.enable = true;
        fish.enable = true;
      };
    };
  };
}
