{
  stdenv,
  fetchurl,
  lib,
}:

let
  pname = "dagger";
  version = "0.19.6";
  platformInfo = {
  "aarch64-darwin" = {
    arch = "darwin_arm64";
    sha256 = "sha256-Pa6hITOY9NF7wg+uVDp/SPqqvwmK1OW59RauDndcqlA=";
  };
  "aarch64-linux" = {
    arch = "linux_arm64";
    sha256 = "sha256-VrAkobEHituT9iNW7ynvop05Xo5+JtQmldYrTDYHMuA=";
  };
  "x86_64-darwin" = {
    arch = "darwin_amd64";
    sha256 = "sha256-/G8v4a8zhYMZBwxtUJ0tuRO/+p3aLDGcKKy1QjVd8ms=";
  };
  "x86_64-linux" = {
    arch = "linux_amd64";
    sha256 = "sha256-6fH4QIx/Kjpgrr08jL/OgGUNa+JcYszpKd2NBxnGHc8=";
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
