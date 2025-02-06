{ moduleBase }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleName = "boot";
in
{
  options = {
    ${moduleBase}.${moduleName} = {
      enable = lib.mkOption {
        default = true;
        description = "do you want this system to boot or no?";
        type = lib.types.bool;
      };
      uefi = {
        enable = lib.mkOption {
          default = true;
          description = "boot system with uefi";
          type = lib.types.bool;
        };

        location = lib.mkOption {
          default = "/boot";
          description = "directory to install boot loader to";
          type = lib.types.str;
        };
      };
    };

  };

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
    boot = {
      loader =
        if config.${moduleBase}.${moduleName}.uefi.enable then
          {
            efi = {
              canTouchEfiVariables = true;
              efiSysMountPoint = "${config.${moduleBase}.${moduleName}.uefi.location}";
            };

            grub = {
              enable = true;
              efiSupport = true;
              device = "nodev";
              useOSProber = true;
              configurationLimit = 50;
            };
          }
        else
          {
            null = throw "Regular non-EFI boot not supported at this time";
          };

      # Fix for F keys on QK75 wireless mode
      kernelParams = [ "hid_apple.fnmode=2" ];
    };
  };
}
