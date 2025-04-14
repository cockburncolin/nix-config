let
  moduleBase = "editors";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./emacs.nix argSet)
  ];
}
