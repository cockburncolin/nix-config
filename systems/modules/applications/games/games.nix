{ ... }:
let
  moduleBase = "games";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./steam.nix argSet)
  ];
}
