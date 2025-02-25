{ ... }:
let
  moduleBase = "games";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./nintendo.nix argSet)
    (import ./prismLauncher.nix argSet)
  ];
}
