{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.8";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-8QzNIQXoBEnPrh8xy5cWbJ3es56HaUshazJ3bUGCNLk=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-W3NUk9/z6HfovjNubQgML56wClzxBD6aqiUXKPEFTgA=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-BiHmBX0fuNVN5jU3WgY1TX5N4+GYQ0fwoHLMzceouG0=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-TH4fLtoGv5PlWvH8NDos2Ye1pNRahnuTl89uRFAofWU=";
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
