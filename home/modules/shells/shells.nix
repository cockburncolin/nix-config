{
  config,
  lib,
  ...
}: let
  moduleBase = "shells";
  argSet = {"moduleBase" = moduleBase;};
in {
  imports = [(import ./zsh.nix argSet)];
}
