let
  caeser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5alTXWq3csEW3JcQrggBwIRPlrYhtrYoCnmSXA9svA";
  brutus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxzifYk38m22wJUWBXcpxQxCMD15e/K2l1kGdimHN4B";
	nix-node01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMdK5r/QFDlg9EmnTciAhZzDkr7KsAqelSqGQXylWmhw";
  hosts = [caeser brutus nix-node01];
in {
  "userpw.age".publicKeys = hosts;
  "rootpw.age".publicKeys = hosts;
  "wifi.age".publicKeys = hosts;
}
