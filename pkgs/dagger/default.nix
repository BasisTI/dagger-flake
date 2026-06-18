{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.21.7";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-uxRyzXHv5AuaXRkpROsLCV6PVWbhh50Whk8tYOednHc=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-eA6N3EJpru6U7yGrfLBsou4Eq+xUhuulP0mnVJ2ZY30=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-iDswSZBnxokDvUxTCIpwZA/YowRNKsAr13h8/PNlAXs=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-REMK/G+cOQ/EfE81KxXekwml6X69GuVjg5YX1t+OjMU=";
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
