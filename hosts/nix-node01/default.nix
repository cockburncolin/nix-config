# template for hosts
{ ... }:
{
  imports = [
    ../common
    ./hardware-config.nix
    ./disk-config.nix
  ];

  config = {
    networking.hostName = "nix-node01";
    time.timeZone = "America/Vancouver";
    networking = {
      useDHCP = false;
      interfaces.ens18 = {
        ipv4.addresses = [
          {
            address = "192.168.1.50";
            prefixLength = 24;
          }
        ];
      };

      defaultGateway = {
        address = "192.168.1.1";
        interface = "ens18";
      };

      nameservers = [ "192.168.1.1" ];
    };
    custom = {
      ssh.enable = true;
    };
  };
}
