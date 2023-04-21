{
  self,
  inputs,
  ...
}: let
  overlay = import ./overlays.nix;
  version = {
    octez_version = "17.0-beta1";
    src = inputs.tezos_next;
  };
in {
  flake = {
    overlays = {
      next = overlay version;
      next' = overlay;
    };
  };

  perSystem = {
    config,
    self',
    inputs',
    system,
    pkgs,
    ...
  }: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        self.overlays.next
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
