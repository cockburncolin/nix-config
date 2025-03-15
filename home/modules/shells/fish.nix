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
  moduleName = "fish";
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
    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "hydro";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "hydro";
            rev = "75ab7168a35358b3d08eeefad4ff0dd306bd80d4";
            sha256 = "0cd6fa6g0jdjdsxgy5qja2jx180s26v5hcs71npj5zim9sqvi2j1";
          };
        }
      ];
    };
  };
}
