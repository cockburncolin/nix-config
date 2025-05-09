{pkgs, ...}: {
  get-aacs-keys = pkgs.callPackage ./scripts/get-aacs-keys {};
  kubero-cli = pkgs.callPackage ./server/kubero-cli {};
  sddm-dracula = pkgs.callPackage ./themes/sddm-dracula {};
}
