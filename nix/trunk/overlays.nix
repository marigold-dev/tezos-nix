final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: {
        # New pacakges

        tezt-ethereum = oself.callPackage ./tezt/tezt-ethereum.nix {};

        # Overrides
        tezos-dal-node-lib = osuper.tezos-dal-node-lib.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.tezos-gossipsub];
        });
      }))
    prev.ocaml-ng;
}
