final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: {
        # New pacakges

        octez-smart-rollup-node = oself.callPackage ./octez/octez-smart-rollup-node.nix {};

        # Overrides
      }))
    prev.ocaml-ng;
}
