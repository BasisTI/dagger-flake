{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.20.8";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-RMv+fuh0iJX4UcN2XIT+Ajx9y2VG9tnP+BqRKuDqnyU=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-5J86oUbzrywln5S8M13/4VRmTt3/TbCt9EXWUDReAFY=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-TY14mZZg/wXvw90BwpymsCN5103usUxWp8b1iWIMk2A=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-wKRlNv3mQfaktFUpOC4RdiINIlUsL5qwE23q8AXmRts=";
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
