{ ... }:
let
  moduleBase = "games";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./lutris.nix argSet)
    (import ./nintendo.nix argSet)
    (import ./prismLauncher.nix argSet)
  ];
}
