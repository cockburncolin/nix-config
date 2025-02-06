{ ... }:
let
  moduleBase = "wm";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./hyprland/hyprland.nix argSet)
  ];
}
