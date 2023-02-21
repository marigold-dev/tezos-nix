{
  self,
  inputs,
  ...
}: let
  overlay = import ./overlays.nix;
  version = {
    octez_version = "20230221";
    src = inputs.tezos_trunk;
  };
in {
  flake = {
    overlays = {trunk = overlay;};
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
        (self.overlays.release version)
        self.overlays.trunk
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
