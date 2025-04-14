{ ... }:
let
  moduleBase = "browsers";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    # (import ./librewolf.nix argSet)
    (import ./vivaldi.nix argSet)
  ];
}
