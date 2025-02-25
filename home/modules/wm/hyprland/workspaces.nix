{ config, lib, ... }:
{
  config.wayland.windowManager.hyprland.settings = {
    workspace = [
      "1,defaultName:1 - Default"
      "2,defaultName:2 - Emacs"
      "3,defaultName:3 - Games"
    ];
  };
}
