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
      sha256 = "sha256-pN+V2V2yNsLk5Jj+GAQIaNmAChg0mKwA8u9kqB2pPDY=";
    };
    "aarch64-linux" = {
      arch = "linux_arm64";
      sha256 = "sha256-UvDI7gF+BppKyjZ0cDa5Rz+M1L56ghqjOZ1IuMI9b+o=";
    };
    "armv7l-linux" = {
      arch = "linux_armv7";
      sha256 = "sha256-F1iCLkM3J4REkMkB8s6QxM7Fh63cEMv6v8eBTR8w6cQ=";
    };
    "x86_64-darwin" = {
      arch = "darwin_amd64";
      sha256 = "sha256-nHop+bYdEw4bI4FvgYqDIi1R4q51kMGR94Akn1A+3+U=";
    };
    "aarch64-darwin" = {
      arch = "darwin_arm64";
      sha256 = "sha256-k60U2NHj2+XN6+K57R/lG+l/YYZmcnJ9OmITnEpmdz0=";
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
