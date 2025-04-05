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
    programs = {
      fish = {
        enable = true;
        loginShellInit = "tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Few icons' --transient=Yes";
        functions = {
          fish_greeting = "";
          create-project = ''
            set dir "$HOME/.local/src/$argv[1]"
            mkdir -p "$dir/src"
            echo "* $argv[1]" >> "$dir/README.org"
            nix flake new --template "https://flakehub.com/f/the-nix-way/dev-templates/*#c-cpp $dir"
            git init $dir
            cd $dir
          '';
        };
        plugins = [
          {
            name = "tide";
            src = pkgs.fetchFromGitHub {
              owner = "IlanCosman";
              repo = "tide";
              rev = "44c521ab292f0eb659a9e2e1b6f83f5f0595fcbd";
              sha256 = "05svj1c6qz1bx7q3vyii7cnls0ibbbvd7dqj39c6crnw1kar967k";
            };
          }
          {
            name = "fzf.fish";
            src = pkgs.fetchFromGitHub {
              owner = "PatrickF1";
              repo = "fzf.fish";
              rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
              hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
            };
          }
        ];
      };
    };
  };
}
