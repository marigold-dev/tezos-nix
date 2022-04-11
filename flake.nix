{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      supportedSystems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      overlay = import ./nix/overlays.nix;
      out = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };
          inherit (pkgs) lib;

          myPkgs = (import ./nix {
            inherit pkgs;
            doCheck = true;
          }).native;
          myDrvs = lib.filterAttrs (_: value: lib.isDerivation value) myPkgs;
        in {
          devShell = (pkgs.mkShell {
            inputsFrom = lib.attrValues myDrvs;
            buildInputs = [ pkgs.nixfmt ];
          });

          packages = myPkgs;

          defaultPackage = myPkgs.tezos-client;

          defaultApp =
            flake-utils.lib.mkApp { drv = self.defaultPackage."${system}"; };

        };
    in with flake-utils.lib; eachSystem supportedSystems out // {
      overlays = {
        default = overlay;
      };
    };
}
