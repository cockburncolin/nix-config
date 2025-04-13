{
  moduleBase ? "misc",
}:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  moduleName = "vscode";
in
{
  imports = [ ];

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
      mutableExtensionsDir = false;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        arrterian.nix-env-selector
        esbenp.prettier-vscode
        jnoortheen.nix-ide
        vscodevim.vim
      ];
      userSettings = {
        "telemetry.enableTelemetry" = false;
        "editor.quickSuggestions" = {
          "other" = true;
          "comments" = true;
          "strings" = true;
        };
        "editor.minimap.enabled" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "nix.formatterPath" = "nixfmt";
      };
    };
    # other dependancies
    home.packages = with pkgs; [ nixfmt-rfc-style ];
  };
}
