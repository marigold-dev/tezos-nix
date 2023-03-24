{
  description = "Nix packaging for Tezos that comes with a devShell";

  nixConfig = {
    extra-substituters = ["https://tezos.nix-cache.workers.dev"];
    extra-trusted-public-keys = ["tezos-nix-cache.marigold.dev-1:4nS7FPPQPKJIaNQcbwzN6m7kylv16UCWWgjeZZr2wXA="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    nix2container.url = "github:nlewo/nix2container";

    tezos_release.url = "gitlab:tezos/tezos/v16.1";
    tezos_release.flake = false;

    tezos_trunk.url = "gitlab:marigold/tezos/d4hines/make-soru-client-public";
    tezos_trunk.flake = false;
  };

  outputs = inputs @ {
    self,
    flake-parts,
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
      flake.hydraJobs = self.packages;
      systems = ["aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        packages.default = config.packages.octez-client;
        devShells.default = config.devShells.dev;

        treefmt.projectRootFile = "flake.nix";
        treefmt.programs.alejandra.enable = true;

        pre-commit.check.enable = true;
        pre-commit.settings.hooks = {
          alejandra.enable = true;
          statix.enable = true;
        };
      };
    };
}
