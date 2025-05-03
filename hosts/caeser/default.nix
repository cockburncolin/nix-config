# template for hosts
{ ... }:
{
  imports = [
    ../common
    ./hardware-config.nix
  ];

  config = {
    networking.hostName = "caeser";
    time.timeZone = "America/Vancouver";
    custom = {
      wifi.enable = true;
      wm.enable = true;
    };
  };
}
