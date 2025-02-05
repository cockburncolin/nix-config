# template for hosts
{...}: {
  imports = [
    ../../modules/bundle.nix
    ./hardware-config.nix
  ];

  config = {
    time.timeZone = "America/Vancouver";
    networking.hostName = "caeser";
  };
}
