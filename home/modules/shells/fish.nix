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
        functions = {
          fish_greeting = "";
          create-project = ''
            set dir "$HOME/.local/src/$argv[1]"
            mkdir -p "$dir"
            git init $dir
            echo "* $argv[1]" >> "$dir/README.org"
            nix flake new --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$argv[2]" $dir
            git add $dir
            git commit -m "initial commit"
            direnv allow $dir
            cd $dir
          '';
        };
        
        shellAliases = {
          cpr = "create-project";
        };
        
        plugins = [
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
