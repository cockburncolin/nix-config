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
    (import ./stylix.nix argSet)
  ];
}
