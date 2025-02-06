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
  moduleName = "sddm";
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
    services.displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      extraPackages = with pkgs; [ where-is-my-sddm-theme ];
      theme = "where-is-my-sddm-theme";
    };
  };
}
