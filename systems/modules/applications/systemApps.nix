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
  moduleName = "systemApps";
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

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
    };
    environment.systemPackages = with pkgs; [
      efibootmgr
      file-rename
      fuse
      git
      man-pages
      man-pages-posix
      nano
      p7zip
      tree
      wget
    ];
    documentation.dev.enable = true;
  };
}
