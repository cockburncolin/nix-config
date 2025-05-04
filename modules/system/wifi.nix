{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.custom.wifi;
in {
  # module options
  options.custom.wifi = {
    enable = lib.mkEnableOption "Enable wifi with home connection";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.wifi = {
      sopsFile = ../../secrets/wifi.env;
      format = "dotenv";
    };

    networking.wireless = {
      enable = true;
      # enable the ability to use wpa_gui or cli
      userControlled.enable = true;

      secretsFile = config.sops.secrets.wifi.path;
      networks.Maverick.pskRaw = "ext:home_pskraw";
    };
  };
}
