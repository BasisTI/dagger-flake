{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.18.17";
  platformInfo = {
    "x86_64-linux" = {
      arch = "linux_amd64";
      sha256 = "sha256-pNeV2V2yNsLlKf4YBKQIbEmAp30UmKwAXvJkqTg8Uh4=";
    };
    "aarch64-linux" = {
      arch = "linux_arm64";
      sha256 = "sha256-UvDI7gG/BJrEsmx0cDa59yrMfaeughqiOdtISMIv/l8=";
    };
    "x86_64-darwin" = {
      arch = "darwin_amd64";
      sha256 = "sha256-nHop/bYQEw5dmRpvgYqDISsUuRp1kCSQUWcUGkDj3+U=";
    };
    "aarch64-darwin" = {
      arch = "darwin_arm64";
      sha256 = "sha256-k60UyNITe7XN2pUO4EhMf+l/YYZlcnJhCzITnDpldz0=";
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
