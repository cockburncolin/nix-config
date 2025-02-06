{moduleBase ? "misc"}: {
  config,
  lib,
  pkg,
  ...
}: let
  moduleName = "zsh";
in {
  options = {
    ${moduleBase}.${moduleName} = {
      enable = lib.mkOption {
        default = true;
        description = "enable zsh settings";
        type = lib.types.bool;
      };
      omz = {
        enable = lib.mkOption {
          default = true;
          description = "enable oh-my-zsh";
          type = lib.types.bool;
        };

        theme = lib.mkOption {
          type = lib.types.str;
          default = "gentoo";
          description = "theme to apply to oh-my-zsh";
        };
      };
    };
  };

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
    programs.zsh = {
      enable = true;
      oh-my-zsh = lib.mkIf config.shells.zsh.omz.enable {
        enable = true;
        plugins = ["git" "sudo"];
        theme = "${config.shells.zsh.omz.theme}";
      };

      shellAliases = {
        hms = "home-manager switch --flake $HOME/.config/nix#desktop";
      };

      dirHashes = {
        nix = "$HOME/.config/nix";
      };
    };
  };
}
