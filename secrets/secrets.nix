let
  caeser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxzifYk38m22wJUWBXcpxQxCMD15e/K2l1kGdimHN4B";
  brutus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5alTXWq3csEW3JcQrggBwIRPlrYhtrYoCnmSXA9svA";
  pliny = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2EheUzT2zbCJ+r3HoCDCz6jso/lB9FCOW1R8XuLN8c nixos@iso";
in {
  "userpw.age".publicKeys = [
    brutus
    caeser
    pliny
  ];
  "wifi.age".publicKeys = [
    brutus
    caeser
    pliny
  ];
}
