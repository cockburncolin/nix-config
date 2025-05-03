{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.custom.sshd;
in
{
  # module options
  options.custom.sshd = {
    enable = lib.mkEnableOption "Enable SSH server";
  };

  config = lib.mkIf cfg.enable rec {
    services.openssh = {
      enable = true;
      ports = [ 9922 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };

    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5alTXWq3csEW3JcQrggBwIRPlrYhtrYoCnmSXA9svA"
    ];

    networking.firewall.allowedTCPPorts = config.services.openssh.ports;
  };
}
