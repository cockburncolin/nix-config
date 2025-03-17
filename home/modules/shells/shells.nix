{
  config,
  pkgs,
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

  # Universial shell settings
  config = {
    # Shell aliases for shells
    home.shellAliases = {
      hms = "home-manager switch --flake $HOME/.config/nix#desktop -b backup";
    };

    # Other shell utils
    home.packages = with pkgs; [
      bat
      fd
      fzf
      thefuck
    ];
  };
}
