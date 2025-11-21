{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.7";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-LMNasMj5YTKR7ah7veuMuNcj/wznXAL3gtYAnRvQPjY=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-u4YCd2fN7ZmUnc0vFQdbeUwetfpqjajwjLOxg3ksI3Q=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-4Lj3twP7PXO0WqoNcqmwPBQX7tuYBIbSREU3o/Ajv3I=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-hyfBkuTwXEIQvbKSgE0snTukvkF5yKAdzwF8mmExwWc=";
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
