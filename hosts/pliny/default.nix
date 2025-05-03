# template for hosts
{ ... }:
{
  imports = [
    ../common
    ./hardware-config.nix
    ./disk-config.nix
  ];

  config = {
    networking.hostName = "pliny";
    time.timeZone = "America/Vancouver";
    custom = {
      sshd.enable = true;
    };
  };
}
