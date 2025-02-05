# Home manager configuration, enable/disable modules here
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [../modules/bundle.nix];

  config = {
    home.username = "colin";
    home.homeDirectory = "/home/colin";

    bar.battery.enable = true;

    home.file = {};

    home.sessionVariables = {
      EDITOR = "codium";
    };

    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
  };
}
