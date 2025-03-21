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
    environment.systemPackages = with pkgs; [ where-is-my-sddm-theme ];
    services.displayManager.sddm = {
      enable = true;
      package = lib.mkForce pkgs.libsForQt5.sddm;
      autoNumlock = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
    };
  };
}
