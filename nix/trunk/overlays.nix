final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: let
        callPackage = oself.callPackage;
      in {
        octez-node-config = callPackage ./tezos/node-config.nix {};
        tezos-layer2-utils-alpha = callPackage ./tezos/layer2-utils-alpha.nix {};
        tezos-alpha =
          osuper.tezos-alpha
          // {
            injector = osuper.tezos-alpha.injector.overrideAttrs (o: {
              propagatedBuildInputs =
                o.propagatedBuildInputs
                ++ [
                  oself.tezos-layer2-utils-alpha
                ];
            });
          };
      }))
    prev.ocaml-ng;
}
