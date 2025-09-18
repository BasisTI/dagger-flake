{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.18.19";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-EhPhLUEzsA9IvnhmwVUrvz3T4si9AAthdfGHftYiDJE=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-0O0Sm1YISqoVY/PW4FIUoqVLj6fkY9vSn/z44fsLmNI=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-j1wlcgYaU4LRBTvRg40vXsh/nsjzMU3YINTqPjrSIao=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-8T82H7OJgNBOLL6A6x+vlXhkVfYcZOXU8s/+yw/t+ig=";
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
