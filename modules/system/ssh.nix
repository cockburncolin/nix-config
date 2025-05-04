{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.custom.ssh;
  authKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5alTXWq3csEW3JcQrggBwIRPlrYhtrYoCnmSXA9svA"
  ];
in {
  # module options
  options.custom.ssh = {
    enable = lib.mkEnableOption "Enable SSH server";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "prohibit-password";
      };
    };

    users.users.root.openssh.authorizedKeys.keys = [] ++ authKeys;

    users.users."${config.custom.user.username}".openssh.authorizedKeys.keys = [] ++ authKeys;

    networking.firewall.allowedTCPPorts = [22];
  };
}
