# Home manager configuration, enable/disable modules here
{
  config,
  pkgs,
  lib,
  inputs,
  ...
<<<<<<< HEAD:home/hosts/desktop.nix
}: {
  imports = [../modules/bundle.nix];
=======
}:
{
  imports = [ ./modules/bundle.nix ];
>>>>>>> anyrun:home/home.nix

  config = {
    home.username = "colin";
    home.homeDirectory = "/home/colin";

    home.file = { };

    home.sessionVariables = {
      EDITOR = "codium";
    };

    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
  };
}
