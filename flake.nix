{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs.follows = "nixpkgs";

    tezos_release.url = "gitlab:tezos/tezos/v14.0";
    tezos_release.flake = false;

    tezos_trunk.url = "gitlab:tezos/tezos";
    tezos_trunk.flake = false;
  };

  outputs = { self, nixpkgs, flake-parts, tezos_release, tezos_trunk }:
    let
      overlay = import ./nix/overlays.nix;
      overlay_trunk = import ./nix/overlays_trunk.nix;
      current_version = { octez_version = "14.0"; src = tezos_release; };
      trunk_version = {
        octez_version = tezos_trunk.rev;
        src = tezos_trunk;
      };
    in
    flake-parts.lib.mkFlake { inherit self; }
      {
        flake = {
          hydraJobs = self.packages;
          overlays = { default = overlay current_version; trunk = overlay_trunk; };
        };
        systems = [ "aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
        perSystem = { config, self', inputs', system, ... }:
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlays.default ];
            };
            pkgs_trunk = import nixpkgs {
              inherit system;
              overlays = [
                (overlay trunk_version)
                self.overlays.trunk
              ];
            };

            tezos_pkgs = pkgs.callPackage ./nix/pkgs.nix { doCheck = true; };

            tezos_pkgs_trunk = pkgs_trunk.callPackage ./nix/pkgs_trunk.nix { doCheck = true; };
          in
          {
            packages = builtins.removeAttrs (tezos_pkgs // tezos_pkgs_trunk) [
              "override"
              "overrideDerivation"
            ] // { default = tezos_pkgs.tezos-client; };
          };
      };
}
