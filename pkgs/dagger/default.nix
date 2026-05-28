{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.21.0";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-/qEytlYRYCTisWE8P2pXUkp4H5In9WBSlRmECmCHjv8=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-jU86ywMRiEZWO++oiTJqtL0gJ0uBRwC5WpWY1Qre6YI=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-C1Fk3yaR8t7CT876o8QrovddwkkaeY9CFvxq47ipb6Y=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-Z4DfbsUZA8jcXmYMTYzbeNhZ/qE4Bwl00DqhPFvwAT0=";
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
