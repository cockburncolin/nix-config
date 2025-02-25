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
    ./bar.nix
    ./binds.nix
    ./monitors.nix
    ./rules.nix
    ./workspaces.nix
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

        animation = [
          "fade, 0"
          "workspaces, 1, 3, easeOutSine"
          "windows, 1, 2, easeOutSine"
        ];

        bezier = [
          "easeOutSine, 0.61, 1, 0.88, 1"
        ];

        decoration = {
          rounding = 7;
          rounding_power = 2;
          blur.enabled = false;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };
        };

        misc = {
          vfr = false;
        };

        master = {
          new_status = "slave";
        };

        monitor = "HDMI-A-1, 2560x1440@144, 0x0, 1";
      };
    };
  };
}
