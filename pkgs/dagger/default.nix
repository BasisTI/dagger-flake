{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.21.9";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-VRpNVDKGBUe/TwiBgcvQkCZoKJFxlZ3pdWjqDw7LNe4=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-O8gzTM3kBPZvCo4pgH5DJ8eJOZDDIRaRaAxfB/gnPzo=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-LtbpmNggv7SADtVkThuVhvAweLFCQ8f9873Z4OsNW/4=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-M+6gsI1r5ES62hjmSyIWRZEA1gcKvLS1NFzuQMn/+YI=";
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
