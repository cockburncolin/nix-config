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
  moduleName = "steam";
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
    hardware.opengl.enable = true;
    hardware.steam-hardware.enable = true;
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      extraPackages = with pkgs; [ gamescope ];
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };
}
