let
  brutus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5alTXWq3csEW3JcQrggBwIRPlrYhtrYoCnmSXA9svA";
  caeser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxzifYk38m22wJUWBXcpxQxCMD15e/K2l1kGdimHN4B";
  nix-node01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZfJynWX43NSomyRM6v4ynKdPbp0h2z/AdiQ/FnMpEj";

  allHosts = [
    brutus
    caeser
    nix-node01
  ];
in
{
  "userpw.age".publicKeys = [ ] ++ allHosts;
  "wifi.age".publicKeys = [ ] ++ allHosts;
}
