# template for hosts
{inputs, pkgs, modulesPath, ... }:
{
  imports = [
    ../common
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  config = {
    networking.hostName = "iso";
    time.timeZone = "America/Vancouver";
    nixpkgs.hostPlatform = "x86_64-linux";
    custom = {
      uefi.enable = false;
      sshd.enable = true;
    };
  };
}
