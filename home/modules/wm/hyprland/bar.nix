{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    bar.battery.enable = lib.mkOption {
      default = false;
      description = "enable battery module";
      type = lib.types.bool;
    };
  };

  config = {
    programs.waybar = {
      enable = true;
      style =
        with config.lib.stylix.colors.withHashtag;
        ''
          @define-color base00 ${base00};
          @define-color base01 ${base01};
          @define-color base02 ${base02};
          @define-color base03 ${base03};
          @define-color base04 ${base04};
          @define-color base05 ${base05};
          @define-color base06 ${base06};
          @define-color base07 ${base07};
          @define-color base08 ${base08};
          @define-color base09 ${base09};
          @define-color base0A ${base0A};
          @define-color base0B ${base0B};
          @define-color base0C ${base0C};
          @define-color base0D ${base0D};
          @define-color base0E ${base0E};
          @define-color base0F ${base0F};
        ''
        + builtins.readFile ./waybar.css;
      systemd.enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          spacing = 8;
          modules-left = [ "hyprland/workspaces" ];
          modules-right =
            if config.bar.battery.enable then
              [
                "pulseaudio"
                "tray"
                "battery"
                "clock"
              ]
            else
              [
                "pulseaudio"
                "tray"
                "clock"
              ];

          # module config
          clock = {
            format = "{:%a %b %d %Y - %I:%M %p %Z}";
          };

          pulseaudio = {
            format = "󰕾  {volume}%";
            on-click = "pavucontrol";
          };

          tray = {
            spacing = 10;
          };

        };
      };
    };
  };
}
