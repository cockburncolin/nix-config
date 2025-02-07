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
  moduleName = "ranger";
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
    programs.ranger = {
      enable = true;
      settings = {
        draw_borders = "both";
      };
    };
  };
}
