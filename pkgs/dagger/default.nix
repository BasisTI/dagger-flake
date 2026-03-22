{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.20.3";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-ts6XAJAAxEQ53BjrVcmbQcSXyP6V0LfkmyN/nsXMwfU=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-0UrgCSON80hwtEdh3Nk6sePnq+x+K+lumO7yxvzoDSg=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-JUXDRTStrtfBKS/Giq7fRo3WQAIEPLa+kUi9SMCAIaM=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-GgpHeVksUTZyXEg5rnHb/DqqWbsizUsB8spVpYPya50=";
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
