{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.4";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-OZA2ZG6CZcW8BmzlBV0MhAOEfUluy6UJcIgaaP/PUf4=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-f8oNIoD86Ai1lC+HiVoH+IZMmY6lFRh4NsPXY3D9RGQ=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-UUsUzl9mYq3d0L1yc8HPo8PaQ4KaZgsaCmOQzjI0drk=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-1c7tQRSwqqkgxpqIXLshHxOmw4kYpSaf784pmYNtExo=";
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
