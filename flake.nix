{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    tezos_release.url = "gitlab:tezos/tezos/v14.0";
    tezos_release.flake = false;

    tezos_trunk.url = "gitlab:tezos/tezos";
    tezos_trunk.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, tezos_release, tezos_trunk }:
    let
      supportedSystems =
        [ "aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
      overlay = import ./nix/overlays.nix;
      overlay_trunk = import ./nix/overlays_trunk.nix;
      current = { octez_version = "14.0"; src = tezos_release; };
      out = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ (overlay current) ];
          };
          inherit (pkgs) lib;

          pkgs_trunk = import nixpkgs {
            inherit system;
            overlays = [
              (overlay {
                octez_version = tezos_trunk.rev;
                src = tezos_trunk;
              })
              overlay_trunk
            ];
          };

          tezos_pkgs = pkgs.callPackage
            ./nix/pkgs.nix
            { doCheck = true; };

          tezos_pkgs_trunk =
            pkgs_trunk.callPackage
              ./nix/pkgs_trunk.nix
              { doCheck = true; };
        in
        rec {
          devShell = (pkgs.mkShell { buildInputs = [ pkgs.nixfmt ]; });

          packages = builtins.removeAttrs (tezos_pkgs // tezos_pkgs_trunk) [
            "override"
            "overrideDerivation"
          ];

          defaultPackage = tezos_pkgs.tezos-client;

          defaultApp =
            flake-utils.lib.mkApp { drv = self.defaultPackage."${system}"; };

          hydraJobs = self.packages."${system}";
        };
    in
    with flake-utils.lib;
    eachSystem
      supportedSystems
      out // {
      overlays = { default = overlay current; };
    };
}
