{
  lib,
  buildGoModule,
  fetchFromGitHub,
  upx,
  kubectl,
}:
buildGoModule rec {
  pname = "kubero-cli";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "kubero-dev";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-a6bwXRxav0klHDBncBc25d5Tw3UE5HM7WwLN7vPvhEo=";
  };

  preBuild = ''
    echo "${version}" > cmd/kuberoCli/VERSION
  '';

  buildInputs = [ upx ];

  vendorHash = "sha256-muZCIMXiceIBfjlEhGFO/azrJ9sxYTDhDXSVwI1Cn2I=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${src.rev}"
    "-X main.commit=${src.rev}"
  ];

  installPhase = ''
    runHook preInstall

    $upx $GOPATH/bin/cmd
    install -Dm755 $GOPATH/bin/cmd $out/bin/kubero-cli

    runHook postInstall
  '';

  meta = with lib; {
    description = "Command line client for Kubero";
    license = licenses.gpl3Only;
    homepage = "https://github.com/kubero-dev/kubero-cli";
  };
}
