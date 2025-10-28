{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.3";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-jL2206p208EjKz6QxoSEKnWdJSDKGBYRLCPJr0w3jPo=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-8FlLv+TxdiwTEC25Prbn8mXyZKdGDKgh37e4tKoXgvY=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-W9RfvUTeOIGQzZCcOS1InlUzeRUHmKKI6RbfIsva6sA=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-FWmSWCgRN1j0Vm1cqWsPoc4kYhXNyZps4tQuOugeYd0=";
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
