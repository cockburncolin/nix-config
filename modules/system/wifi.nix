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
    age.secrets.wifi.file = ../../secrets/wifi.age;

    networking.wireless = {
      enable = true;
      # enable the ability to use wpa_gui or cli
      userControlled.enable = true;

      secretsFile = config.age.secrets.wifi.path;
      networks.Maverick.psk = "TooManyRaindropTitties";
    };
  };
}
