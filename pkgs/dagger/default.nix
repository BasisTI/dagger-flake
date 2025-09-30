{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.0";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-l1S81+X/Pr46NDVXvopOp/It9uZaDt6Db+oucI8YSs4=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-WwH2gWOn9ZL5X/LO1pr0S3uWEVTwNPqn2wP6bCzrpgI=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-8UKntISpj+xeIDViOA6Y0J7IcCKkLKVtQUTDsPkUY1g=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-0m/DyO5tOyOHXLvZxv86G0qYIbrL9jAko6DurkZQ5rg=";
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
