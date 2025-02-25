{ config, lib, ... }:
{
  config.wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "workspace 2, title:(.*)(Gnu Emacs)(.*)"
      "workspace 3, class:steam"
    ];
  };
}
