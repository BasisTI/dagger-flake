{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.10";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-FsdJwJ+sUyaFIUsAB3BtPf8hKKw+zvAGKIyvORAfJCc=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-LlBfbRxZhaANbGo6EmdhxL+1uhKBhlZZIaxAJSC62MY=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-qn13kj7LLEsMgBtPDxCCz340qJ0LP/flGF37b1ASxIo=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-PJ37EejfiiETOEN4mp3JyUdxduRevwBEKji8+cukkgo=";
  };
};











  platform = lib.getAttr stdenv.hostPlatform.system platformInfo;
in
stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/dagger/dagger/releases/download/v${version}/${pname}_v${version}_${platform.arch}.tar.gz";
    sha256 = platform.sha256;
  };

  phases = [
    "unpackPhase"
    "installPhase"
  ];
  unpackPhase = "tar -xzf $src";
  installPhase = "install -Dm755 dagger $out/bin/dagger";

  meta = with lib; {
    description = "Dagger CLI – composable CI/CD runtime";
    homepage = "https://dagger.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ cedric-lamalle ];
    platforms = platforms.darwin ++ platforms.linux;
  };
}
