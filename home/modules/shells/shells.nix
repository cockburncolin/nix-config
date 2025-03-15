{
  config,
  lib,
  ...
}:
let
  moduleBase = "shells";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./zsh.nix argSet)
    (import ./fish.nix argSet)
  ];

  config = {
    # Shell aliases for shells
    home.shellAliases = {
      hms = "home-manager switch --flake $HOME/.config/nix#desktop -b backup";
    };
  };
}
