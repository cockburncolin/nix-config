{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.custom.wm;
in {
  options.custom.wm = {
    enable = lib.mkEnableOption "Enable GUI";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyprpaper
      mako # notification system developed by swaywm maintainer
      sddm-dracula
      wl-clipboard
      waybar
      wofi
    ];

    services.xserver.enable = true;

    services.displayManager.sddm = {
      enable = true;
      package = lib.mkForce pkgs.libsForQt5.sddm;
      autoNumlock = true;
      wayland.enable = true;
      theme = "${pkgs.sddm-dracula}";
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome.gnome-keyring.enable = true;

    # user services
    systemd.user.services = {
      hyprpaper = {
        enable = true;
        description = "hyprpaper is a fast, IPC-controlled wallpaper utility for Hyprland";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
          wantedBy = ["default.target"];
        };
      };

      waybar = {
        enable = true;
        description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.waybar}/bin/waybar";
          wantedBy = ["default.target"];
        };
      };
    };
  };
}
