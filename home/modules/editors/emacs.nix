# Takes moduleBase from importing file
{
  moduleBase ? "misc",
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleName = "emacs";
  emacsDir = config.lib.file.mkOutOfStoreSymlink "/home/colin/.config/nix/home/modules/editors/emacs.d";
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
    };
  };

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
    xdg.configFile."emacs" = {
      source = emacsDir;
    };

    programs.emacs = {
	enable = true;
	package = pkgs.emacs-gtk;
    };

    # Required for vterm
    home.packages = with pkgs; [
      cmake
      gcc
      gnumake
      libtool
    ];
  };
}
