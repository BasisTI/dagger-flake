{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.9";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-CE+Aw5cBCkFdILExs4X8UOQfCSI8rKDhU1lQWFEogEw=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-8cPGpfII/OOhsdTNg0eKLEsuJxJuJpARYZ1agqX7OIY=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-HAvwofi9waad8T5bAG9g/xBjuNYJ04swDLMoN1KPbKM=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-AuXpefdFBOAICm2unbcXzAAEKXlMENQpuKRnelLdWTk=";
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
