{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.2";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-GlsJZEvZCA4c5U9gtpnAH/6WqSFcA1EZkA76F6VDH8w=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-eqs2ze26Uqb5ifj28yEljpbU+ibww+gfUoepAO73zFM=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-kJmp21PPuKK3kONvjglkn1ihdk7xq39xK27D7g1GLSA=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-xfnZTBokBNdaKwDdQ2GeorKbr3kiufk/SRUxsh6MGxg=";
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
