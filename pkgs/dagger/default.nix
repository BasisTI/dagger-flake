{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.5";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-6LOPOFUiE9eRpFgayDQPYmqdxm6+sZ3F0UKq0IwWKvo=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-A/iLEVUED/l7fkBpp8jcc8o9acFVien6vgweEhPcGDM=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-ggD2p67lVeptxT3sxImdTsp067ekqsMBrIuEJ7sXt3k=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-jKf+L8M530dHfuXk1eNYieMbOYJga/59YW9ABxVVZIc=";
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
