# template for hosts
{ ... }:
{
  imports = [
    ../../modules/bundle.nix
    ./hardware-config.nix
  ];

  config = {
    networking.hostName = "caeser";
    networking.firewall.checkReversePath = false;
    time.timeZone = "America/Vancouver";
  };
}
