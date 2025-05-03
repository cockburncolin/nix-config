{pkgs, ...}: {
  kubero-cli = pkgs.callPackage ./server/kubero-cli {};
  sddm-dracula = pkgs.callPackage ./themes/sddm-dracula {};
}
