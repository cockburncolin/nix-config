{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-dracula";

  src = pkgs.fetchFromGitHub {
    owner = "denismhz";
    repo = "sddm-sugar-dracula";
    rev = "300e6b4faca811af9671942e77180f24dba33345";
    sha256 = "087nal7gw3170ayigbg5j5z0cadph8nwkdaip20mi0xcv71c811r";
  };

  dontWrapQtApps = true;

  buildInputs = with pkgs.libsForQt5.qt5; [
    qtsvg
    qtquickcontrols2
    qtgraphicaleffects
  ];

  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
