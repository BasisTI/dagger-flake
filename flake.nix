{
  description = "Flake packaging the Dagger CLI";

  inputs = {
    nixpkgs     = { url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = {
          dagger  = pkgs.callPackage ./pkgs/dagger { };
          default = self.packages.${system}.dagger;
        };
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.nixpkgs-fmt pkgs.niv ];
        };
      });
}
