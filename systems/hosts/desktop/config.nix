# template for hosts
{ ... }:
{
  imports = [
    ../../modules/bundle.nix
    ./hardware-config.nix
  ];

  config = {
    hardware.opengl.enable = true;
    hardware.steam-hardware.enable = true;
    networking.hostName = "caeser";
    time.timeZone = "America/Vancouver";
  };
}
