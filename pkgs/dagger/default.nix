{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.21.11";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-WEkNsi4dl19uRUlV5gXQ+QVkUXczUosY1l9K15KbY1A=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-ehn8Fs5Y2KqA4nNimjijzz5JlR34kos4qQiAXJoIzFA=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-6s3peus+46DBxijTdNuwGiMDZA8Qu2c55onBBEJJa+4=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-otPvlucwWrwYZjo2BtnBxZIni6PI9I4B1r4U7vcidu8=";
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
