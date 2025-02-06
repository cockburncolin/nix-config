{ ... }:
let
  moduleBase = "apps";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./pkgConf.nix argSet)
    (import ./sound.nix argSet)
    (import ./stylix.nix argSet)
    (import ./systemApps.nix argSet)
    ./displayManagers/displayManagers.nix
    ./windowManagers/windowManagers.nix
  ];
}
