{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.custom.wifi;
in {
  # module options
  options.custom.wifi = {
    enable = lib.mkEnableOption "Enable wifi with home connection";
  };

  config = lib.mkIf cfg.enable {
    age.secrets.wifienv = {
      file = ../../secrets/wifi.age;
      owner = "root";
      group = "root";
      path = "/run/secrets/wifi.env";
      mode = "770";
      symlink = false;
    };

    networking.wireless = {
      enable = true;
      # enable the ability to use wpa_gui or cli
      userControlled.enable = true;

      secretsFile = config.age.secrets.wifienv.path;
      networks.Maverick.pskRaw = "ext:home_pskraw";
    };
  };
}
