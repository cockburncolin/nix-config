{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.wm;
in
{
  options.custom.wm = {
    enable = lib.mkEnableOption "Enable GUI";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mako # notification system developed by swaywm maintainer
      sddm-dracula
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

    # enable sway window manager
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };
}
