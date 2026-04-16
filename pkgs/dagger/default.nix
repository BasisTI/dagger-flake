{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.20.6";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-bTHXv51J8M3jQ/ReCMaY+4JEfinbfHHPha617dvxu6Y=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-EBjisLG+yuNlBCiQK4QduCyF/iHPCyL+/O+DnTDVGYk=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-EnTB8QkgbHKN1b98rFjiHiXcz+yDja4gi9q5tJXJImM=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-O/zLhBppVO5rRsCr73dXKjDEqlBmH/cvuTQN4EIeL0U=";
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
