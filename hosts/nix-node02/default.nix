# template for hosts
{...}: {
  imports = [
    ../common
    ./hardware-config.nix
    ./disk-config.nix
  ];

  config = {
    networking.hostName = "nix-node01";
    time.timeZone = "America/Vancouver";
    custom = {
      ssh.enable = true;
    };
  };
}
