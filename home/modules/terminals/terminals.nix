{...}: let
  moduleBase = "terminals";
  argSet = {"moduleBase" = moduleBase;};
in {
  imports = [
    (import ./kitty.nix argSet)
  ];
}
