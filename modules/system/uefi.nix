{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.uefi;
in {
  options.custom.uefi = {
    enable = lib.mkEnableOption "Boot the system with uefi";
    location = lib.mkOption {
      default = "/boot";
      description = "Location to install loader to";
      example = "/boot";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "${cfg.location}";
        };

        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
          configurationLimit = 50;
        };
      };

      kernelModules = ["sg"];
      kernelParams = [
        "hid_apple.fnmode=2" # fix issue with QK75 F keys
      ];
    };
  };
}
