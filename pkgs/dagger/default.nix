{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.21.8";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-8/N6gxr9U9Cb+cmp32NJLBatQ2IuXBl9mBXoLzNO8cQ=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-zQ30iF8gUAgpMrSrxaaq2acz9qpOfYR0dAVYUX/+xK8=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-R1m+/j+pUf0roFVRMGAj336Mf8nv9Xu4I0gYA8tEshU=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-U+Imx9qPt1Fx5Yw1dZ1zbZYc6LOhLbC6p7cQeVT8zFo=";
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
