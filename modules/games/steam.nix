{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.custom.steam;
in {
  # module options
  options.custom.steam = {
    enable = lib.mkEnableOption "Install steam";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
}
