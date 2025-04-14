# Takes moduleBase from importing file
{
  moduleBase ? "misc",
}:
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  moduleName = "emacs";
  emacsPkg = pkgs.emacs-gtk;
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
    xdg.configFile."emacs" =
      let
        srcpath = "${config.xdg.configHome}/nix/home/modules/editors/emacs.d";
      in
      {
        source = config.lib.file.mkOutOfStoreSymlink srcpath;
      };

    programs.emacs = {
      enable = true;
      # Allows deletion of standalone emacs desktop file,
      # reduces clutter in app launchers since I want to use client only
      package = pkgs.symlinkJoin {
        meta = emacsPkg.meta or "";
        name = "emacs-without-desktop";
        passthrough = emacsPkg.passthrough or "";
        paths = [ emacsPkg ];
        postBuild = ''
          rm -f $out/share/applications/emacs.desktop
          sed -i 's/^\(Exec=\).*$/\1emacsclient -r/g' $out/share/applications/emacsclient.desktop
        '';
      };
    };

    services.emacs = {
      enable = true;
      defaultEditor = true;
    };
  };
}
