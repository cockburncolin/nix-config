{ ... }:
let
  moduleBase = "net"; # not calling this networking due to collision with default config options
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [ (import ./networkManager/networkManager.nix argSet) ];
}
