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
      hms = "home-manager switch --flake $HOME/.config/nix#$hostname -b backup";
      hmn = "home-manager news";
      nrbs = "sudo nixos-rebuild switch --flake $HOME/.config/nix#$hostname --upgrade";
    };

    home.sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = 1;
    };

    # Other shell utils
    home.packages = with pkgs; [
      bat
      fd
      fzf
    ];

    programs = {
      thefuck.enable = true;
    };
  };
}
