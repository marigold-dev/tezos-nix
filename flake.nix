{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      out = system:
        let
          version = "12.3";
          src = nixpkgs.legacyPackages.${system}.fetchFromGitLab {
            owner = "tezos";
            repo = "tezos";
            rev = "v${version}";
            sha256 = "sha256-j0phPzuj9FLfMyqwMuUeolYQLh2eF3CY9XHSScqgQnk=";
          };
          tezos_overlay = import ./nix/tezos.nix { inherit src version; };
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ tezos_overlay ];
          };
          inherit (pkgs) lib;

          myPkgs = pkgs.recurseIntoAttrs (import ./nix {
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
    in with flake-utils.lib; eachSystem defaultSystems out;
}
