{moduleBase ? "misc"}: {
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "gitConfig";
in {
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
    programs.git = {
      aliases = {
        pu = "push";
        co = "checkout";
        cm = "commit -m";
      };
      enable = true;
      extraConfig = {
        push = {autoSetupRemote = true;};
        init = {defaultBranch = "master";};
      };
      userEmail = "51009168+cockburncolin@users.noreply.github.com";
      userName = "cockburncolin";
    };
  };
}
