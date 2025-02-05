{ ... }:
let
  moduleBase = "";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./submodule.nix argSet)
  ];
}
