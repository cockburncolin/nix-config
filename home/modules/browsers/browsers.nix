{ ... }:
let
  moduleBase = "browsers";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    # (import ./firefox.nix argSet)
    (import ./librewolf.nix argSet)
  ];
}
