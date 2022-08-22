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
    flake-parts.lib.mkFlake { inherit self; }
      {
        imports = [
          ./nix/release
          ./nix/trunk
        ];
        flake = {
          hydraJobs = self.packages;
        };
        systems = [ "aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
        perSystem = { config, self', inputs', system, ... }: {
          packages = { default = self'.packages.tezos-client; };
        };
      };
}
