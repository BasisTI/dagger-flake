{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.18.18";
  platformInfo = {
    "x86_64-linux" = {
      arch = "linux_amd64";
      sha256 = "sha256-eShWHsdjXD/55NF4sikbqxiCuEzmQ2Rl8SMLK+wbAwU=";
    };
    "aarch64-linux" = {
      arch = "linux_arm64";
      sha256 = "isha256-mZo/qTatcUYo0SJgKxNEzzGTjK4IR0xxvNn5AkWZKfM=";
    };
    "x86_64-darwin" = {
      arch = "darwin_amd64";
      sha256 = "sha256-z0mEDgDl/mn8RG80rON2kjbENHdqlvpPSbDfxnpJ6RU=";
    };
    "aarch64-darwin" = {
      arch = "darwin_arm64";
      sha256 = "sha256-e/NxP+iVBn07s3cHRbVPZF+adJ4k4gKNOi62pWVqzA0=";
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
