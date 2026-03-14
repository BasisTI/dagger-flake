{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.20.1";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-5zXTjVCDTzcmVgWl72lVovKL/0mX8eMk1t5VzY8NUhU=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-2k2oFOCjdUDIi9EH6kZnvNrhSApmVgiPQeytGPArYzQ=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-GkS1V4PcwK0iqRPMVN3K5OaCtHSKm+RP77SxhigAa4o=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-ASr6gZqdRZOJrzTxBVwGTcEXiBCAv5HcMaa0aU8rz5k=";
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
