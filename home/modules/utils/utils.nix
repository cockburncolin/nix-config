{ ... }:
let
  moduleBase = "utils";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./anyrun.nix argSet)
    (import ./disk-rip.nix argSet)
    (import ./ranger.nix argSet)
    (import ./stylix.nix argSet)
    (import ./vpn.nix argSet)
    (import ./wine.nix argSet)
    (import ./zathura.nix argSet)
  ];
}
