{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.11";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-AtaTgaB6vUMU8grkyZ0FxFNeBriVp58P1bb8WruNOhw=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-FxOKalqvDe54VQzzmDHeYMmllRZTBGep5RqTjCHuLk4=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-16LPlgjlunRL3PGM08x9suQ/yKPyh/MdREmU+o/KW0c=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-OXisvW7KJecNSp9Nhyh3Fmn0wzoHbONXiSRj9ERgHWQ=";
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
