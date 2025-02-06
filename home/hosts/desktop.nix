# Home manager configuration, enable/disable modules here
{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ ../modules/bundle.nix ];

  config = {
    home.username = "colin";
    home.homeDirectory = "/home/colin";
    nixpkgs.config.allowUnfree = true;
    home.file = { };

    home.sessionVariables = {
      EDITOR = "codium";
    };

    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
  };
}
