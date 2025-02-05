# Takes moduleBase from importing file
{moduleBase ? "misc"}: {
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "mpv";
in {
  imports = [];

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
    programs.mpv = {
      enable = true;
      config = {
        profile = "gpu-hq";
        force-window = true;
        ytdl-format = "bestvideo+bestaudio";
        cache-default = 4000000;
      };
    };
    programs.yt-dlp = {
      enable = true;
      settings = {};
    };
    services.plex-mpv-shim.enable = true;
  };
}
