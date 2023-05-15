final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: {
        # New pacakges

        # Overrides
      }))
    prev.ocaml-ng;
}
