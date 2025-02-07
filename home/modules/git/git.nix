{ ... }:
let
  moduleBase = "git";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./gitConfig.nix argSet)
    (import ./lazyGit.nix argSet)
  ];
}
