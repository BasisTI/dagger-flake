{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.21.10";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-TJQS5vBcn/JkXewgGPMC3ZuhRLrfnqdi2P88Cx3RJZw=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-0bINS4gVutxahHjnyPwQMcNVwCp8G+sFUJr/MpZdxY4=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-JGTiqelWYMI3sEwHjw33L+I92LOqQ95q9D7Lmycv0K4=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-+e4IN2fdEs2sWD+ds/7b67uzBk9pFSmYvh8SHRpswQM=";
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
