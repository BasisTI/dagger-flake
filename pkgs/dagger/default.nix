{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.20.4";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-bFDhUHdo92+u0TYMASJpqb9SOt222sqVLxCn5Tx5oTI=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-OUHGJ53CmDHhCethhiti7K3PZQe2Tg4ynNQLOFGoV2c=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-fXbIALEXRB+C4CM4UIyxi4kW9z10QYaSmmVgij2AzjU=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-kSfIIReGqsxsyKScyC/+oqp1+yTiP/SahZMFBb//PBQ=";
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
