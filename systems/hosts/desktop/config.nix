# template for hosts
{ ... }:
{
  imports = [
    ../../modules/bundle.nix
    ./hardware-config.nix
  ];

  config = {
    networking.hostName = "caeser";
    time.timeZone = "America/Vancouver";
  };
}
