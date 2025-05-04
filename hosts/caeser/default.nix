# template for hosts
{...}: {
  imports = [
    ../common
    ./hardware-config.nix
  ];

  config = {
    networking.hostName = "caeser";
    time.timeZone = "America/Vancouver";

		
	age.identityPaths = ["/home/colin/.ssh/id_ed25519"];

    custom = {
      wifi.enable = true;
      wm.enable = true;
    };
  };
}
