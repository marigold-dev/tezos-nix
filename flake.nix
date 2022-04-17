{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      supportedSystems =
        [ "aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
      overlay = import ./nix/overlays.nix;
      overlay_trunk = import ./nix/overlays_trunk.nix;
      out = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };
          inherit (pkgs) lib;

          pkgs_trunk = import nixpkgs {
            inherit system;
            overlays = [ overlay_trunk ];
          };

          tezos_pkgs = pkgs.callPackage ./nix/pkgs.nix { doCheck = true; };

          tezos_pkgs_trunk =
            pkgs_trunk.callPackage ./nix/pkgs_trunk.nix { doCheck = true; };
        in rec {
          devShell = (pkgs.mkShell { buildInputs = [ pkgs.nixfmt ]; });

          packages = builtins.removeAttrs (tezos_pkgs // tezos_pkgs_trunk
            // (pkgs.callPackage ./nix/hydra_spec.nix { })) [
              "override"
              "overrideDerivation"
            ];

          defaultPackage = tezos_pkgs.tezos-client;

          defaultApp =
            flake-utils.lib.mkApp { drv = self.defaultPackage."${system}"; };

          hydraJobs = self.packages."${system}";
        };
    in with flake-utils.lib;
    eachSystem supportedSystems out // {
      overlays = { default = overlay; };
    };
}
