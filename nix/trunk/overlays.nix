final: prev: {
  ocaml-ng =
    builtins.mapAttrs
      (ocamlVersion: curr_ocaml:
        curr_ocaml.overrideScope' (oself: osuper: {
          tezos-event-logging-test-helpers = osuper.tezos-event-logging-test-helpers.overrideAttrs (o: rec {
            propagatedBuildInputs = o.propagatedBuildInputs ++ [ oself.octez-alcotezt ];
          });
        }))
      prev.ocaml-ng;
}
