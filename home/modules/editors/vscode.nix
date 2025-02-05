{
  config,
  pkgs,
  lib,
  ...
}: let
  moduleBase = "editors";
  moduleName = "vscode";
in {
  imports = [];

  options = {
    ${moduleBase}.${moduleName}.enable = lib.mkOption {
      default = true;
      description = "enable ${moduleName}";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.${moduleBase}.${moduleName}.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        vscodevim.vim
        kamadorueda.alejandra
      ];
      userSettings = {
        "telemetry.enableTelemetry" = false;
        "editor.quickSuggestions" = {
          "other" = false;
          "comments" = false;
          "strings" = false;
        };
        "editor.minimap.enabled" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;
      };
    };
  };
}
