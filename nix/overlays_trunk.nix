final: prev:

{
  ocaml-ng = builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper:
        let
          callPackage = oself.callPackage;
          fix_platforms = package:
            package.overrideAttrs
              (_: { meta = { platforms = oself.ocaml.meta.platforms; }; });
        in
        {
          lazy-containers = oself.callPackage ./tezos/trunk/lazy-containers.nix { };
          tree-encoding = oself.callPackage ./tezos/trunk/tree-encoding.nix { };
          tezos-context = oself.callPackage ./tezos/trunk/context.nix { };
          tezos-shell-services = oself.callPackage ./tezos/trunk/shell-services.nix { };
          tezos-test-helpers-extra = oself.callPackage ./tezos/trunk/test-helpers-extra.nix { };
          tezos-crypto-dal = oself.callPackage ./tezos/trunk/crypto-dal.nix { };
          tezos-bls12-381-polynomial = oself.callPackage ./tezos/trunk/bls12-381-polynomial.nix { };

          tezos-webassembly-interpreter = osuper.tezos-webassembly-interpreter.overrideAttrs (o: {
            propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [ lazy-containers ]);
          });

          tezos-scoru-wasm = osuper.tezos-scoru-wasm.overrideAttrs (o: {
            propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [ lazy-containers tree-encoding ]);
          });

          tezos-protocol-environment = osuper.tezos-protocol-environment.overrideAttrs (o: {
            propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [ tezos-crypto-dal ]);
          });

          tezos-protocol-updater = osuper.tezos-protocol-updater.overrideAttrs (o: {
            propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [ tezos-shell-services ]);
          });

          tezos-shell = osuper.tezos-shell.overrideAttrs (o: {
            propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [ tezos-workers ]);
          });
        }))
    prev.ocaml-ng;
}
