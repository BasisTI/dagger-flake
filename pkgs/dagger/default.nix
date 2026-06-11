{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.21.5";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-YfUkSJJ8+9VxXwOF9H4fUAzO9U2Axy/9+UBIhMLmULM=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-D36iSpt4O+D8VNUSyZIUVGQLCwsDVf/jguMkXCFF5eM=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-rXHyhPxw0WT0mrTe9PRY8ksdXfweOYH6Wwj+5zp3vtQ=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-ZtUSDKtHLT65mXEHnWhy1D8R1CRKsI4yqA1+MeoPO0I=";
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
