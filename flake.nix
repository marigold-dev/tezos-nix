{
  description = "Tezos packaged for nix";

  nixConfig = {
    extra-substituters = ["https://tezos.nix-cache.workers.dev"];
    extra-trusted-public-keys = ["tezos-nix-cache.marigold.dev-1:4nS7FPPQPKJIaNQcbwzN6m7kylv16UCWWgjeZZr2wXA="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    tezos_release.url = "gitlab:tezos/tezos/v14.1";
    tezos_release.flake = false;

    tezos_trunk.url = "gitlab:tezos/tezos";
    tezos_trunk.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    alejandra,
    tezos_release,
    tezos_trunk,
  }:
    flake-parts.lib.mkFlake {inherit self;}
    {
      imports = [
        ./nix/release
        ./nix/trunk
      ];
      flake = {
        hydraJobs = self.packages;
        formatter = alejandra.defaultPackage;
      };
      systems = ["aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
      perSystem = {
        self',
        pkgs',
        system,
        ...
      }: {
        packages = {default = self'.packages.tezos-client;};
      };
    };
}
