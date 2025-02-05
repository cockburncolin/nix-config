{ ... }:
let
  moduleBase = "apps.displayManagers";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./sddm.nix argSet)
  ];
}
