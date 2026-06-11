{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.21.6";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-5p9Ay449/dbP32jjDrTZ19lcOtG8heQLlVA+hh4NY6Y=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-L+Nqyio5IVLG8fwehmY4czy9k3IKqudwBdSDqz66D4I=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-JRLsX/zPmYibUKdT6hQT50ZNgCJJKkZIpWeSkm0MRBY=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-CxD19GSEPcFU+uRyea1m5GXXWiEYsyFROUtzg8DqrE8=";
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
