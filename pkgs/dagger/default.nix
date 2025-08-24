{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.18.16";
  platformInfo = {
    "x86_64-linux" = {
      arch = "linux_amd64";
      sha256 = "sha256-bD4AsrmbEfKRhte6gXjLvJMGtGuytuoF9uFpj2Ol7cQ=";
    };
    "aarch64-linux" = {
      arch = "linux_arm64";
      sha256 = "sha256-dobyQS7161IOobgB+DNsKMFbq6D9CIEZ/7lFv5g5JXE=";
    };
    "x86_64-darwin" = {
      arch = "darwin_amd64";
      sha256 = "sha256-H+rKkSaNvKgQtWhZksUi6hPMRfZlIae8yB+SWpx+LCM=";
    };
    "aarch64-darwin" = {
      arch = "darwin_arm64";
      sha256 = "sha256-zzShyzgVGBq5IgUm2RJwp2WZHRYC51BF5hn/zGbjEl8=";
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
