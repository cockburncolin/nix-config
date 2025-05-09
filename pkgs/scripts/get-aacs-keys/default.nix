{
  lib,
  stdenv,
  gcc,
  libzip,
  curl,
}:
stdenv.mkDerivation rec {
  name = "get-aacs-keys";
  src = ./.;

  buildInputs = [curl libzip];

  buildPhase = ''
    ${gcc}/bin/gcc -o get-aacs-keys get-aacs-keys.c -Wall -lcurl -lzip
  '';

  installPhase = ''
    install -d -m755 $out/bin/
    cp ${name} $out/bin/${name}
  '';
}
