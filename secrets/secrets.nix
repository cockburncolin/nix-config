let
  caeser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxzifYk38m22wJUWBXcpxQxCMD15e/K2l1kGdimHN4B";
  brutus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5alTXWq3csEW3JcQrggBwIRPlrYhtrYoCnmSXA9svA";
  pliny =  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8f0upV9tKUzknc9uJmzDyqH20bFWe0mcAqkGg/YYgF";
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
