{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.20.5";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-8l4XAVs3AbA/T47LtJvX2QbnHGtT8KusmxOynf8fnWA=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-ChyKGco6P8Co0t4VpyvV57UIBnlL7IkVRKPeCYOGMXk=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-IISp/ynjCu5DZLtrEeBtKjPhlQIJb17B5dC0ibZLEtM=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-LKukiu6KXcqOAdvIqslGT4O/fSRk1Tz0yXG2Gt9Plzg=";
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
