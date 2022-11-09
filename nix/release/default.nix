{
  self,
  inputs,
  ...
}: let
  overlay = import ./overlays.nix;
  version = {
    octez_version = "15.0";
    src = inputs.tezos_release;
  };
in {
  flake = {
    overlays = {
      default = overlay version;
      release = overlay;
    };
  };

  perSystem = {
    config,
    self',
    inputs',
    system,
    ...
  }: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        self.overlays.default
      ];
    };

    tezos_pkgs = pkgs.callPackage ./pkgs.nix {doCheck = true;};
  in {
    packages = builtins.removeAttrs tezos_pkgs [
      "override"
      "overrideDerivation"
    ];
  };
}
