# Takes moduleBase from importing file
{
  moduleBase ? "misc",
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleName = "emacs";
in
{
  imports = [ ];

  options = {
    "${moduleBase}"."${moduleName}" = {
      enable = lib.mkOption {
        default = true;
        description = "enable ${moduleName}";
        type = lib.types.bool;
      };
    };
  };

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
   xdg.configFile."emacs" = {
     source = ./emacs.d;
     recursive = true;
     # onChange  = "${config.home.homeDirectory}/.nix-profile/bin/systemctl --user restart emacs"; # use at your own risk, will force emacs to restart, SAVE EVERYTHING BEFORE REBUILDING!
   };

   services.emacs = {
      enable = true;
     defaultEditor = true;
     client.enable = true;
     startWithUserSession = true;
   };
  };
}
