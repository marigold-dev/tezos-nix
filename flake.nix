{
  description = "Tezos packaged for nix";

  nixConfig = {
    extra-substituters = ["https://tezos.nix-cache.workers.dev"];
    extra-trusted-public-keys = ["tezos-nix-cache.marigold.dev-1:4nS7FPPQPKJIaNQcbwzN6m7kylv16UCWWgjeZZr2wXA="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    tezos_release.url = "gitlab:tezos/tezos/v16.0-rc2";
    tezos_release.flake = false;

    tezos_trunk.url = "gitlab:tezos/tezos";
    tezos_trunk.flake = false;
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    tezos_release,
    tezos_trunk,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;}
    {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.pre-commit-hooks.flakeModule
        ./nix/release
        ./nix/trunk
      ];
      flake = {
        hydraJobs = self.packages;
      };
      systems = ["aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
      perSystem = {
        self',
        pkgs,
        system,
        ...
      }: {
        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
          };
        };
        pre-commit = {
          check.enable = true;
          settings = {
            hooks = {
              alejandra.enable = true;
              statix.enable = true;
            };
          };
        };
        packages = {default = self'.packages.octez-client;};
      };
    };
}
