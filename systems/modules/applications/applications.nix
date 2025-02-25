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
    (import ./vms.nix argSet)
    ./displayManagers/displayManagers.nix
    ./games/games.nix
    ./windowManagers/windowManagers.nix
  ];
}
