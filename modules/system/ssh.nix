{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.custom.ssh;
in
{
  # module options
  options.custom.ssh = {
    enable = lib.mkEnableOption "Enable SSH server";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "prohibit-password";
      };
    };

    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5alTXWq3csEW3JcQrggBwIRPlrYhtrYoCnmSXA9svA"
    ];

    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
