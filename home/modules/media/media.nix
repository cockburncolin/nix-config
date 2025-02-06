{ ... }:
let
  moduleBase = "media";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./mpv.nix argSet)
  ];
}
