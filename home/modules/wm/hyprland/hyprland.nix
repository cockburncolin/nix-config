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
  moduleName = "hyprland";
in
{
  imports = [
    ./binds.nix
    ./bar.nix
    ./monitors.nix
  ];

  options = {
    ${moduleBase}.${moduleName}.enable = lib.mkOption {
      default = true;
      description = "manage ${moduleName}";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.${moduleBase}.${moduleName}.enable {
    # Required to get file picker working in firefox
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = [ "--all" ];
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      settings = {
        general = {
          gaps_in = 10;
          gaps_out = 20;
          allow_tearing = false;
          resize_on_border = true;

          layout = "master";
        };

        decoration = {
          rounding = 7;
          rounding_power = 2;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };
        };

        master = {
          new_status = "slave";
        };

        monitor = "HDMI-A-1, 2560x1440@144, 0x0, 1";
      };
    };
  };
}
