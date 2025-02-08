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
    home.file.".emacs.d" = {
      source = ./emacs.d;
      recursive = true;
    };

    services.emacs = {
    	enable = true;
	defaultEditor = lib.mkForce true;
	client.enable = true;
    };
  };
}
