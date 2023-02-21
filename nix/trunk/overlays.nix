final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: let
        inherit (oself) callPackage;
      in {
        tezos-bls12-381-polynomial-internal = callPackage ./tezos/bls12-381-polynomial-internal.nix {};

        tezos-dal-node-services = callPackage ./tezos/dal-node-services.nix {};

        tezos-dal-node-lib = callPackage ./tezos/dal-node-lib.nix {};

        tezos-layer2-store = callPackage ./tezos/layer2-store.nix {};

        tezos-dal-016-PtMumbai = callPackage ./tezos/dal-016-PtMumbai.nix {};

        tezos-crypto-dal = osuper.tezos-crypto-dal.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.tezos-bls12-381-polynomial-internal];

          checkInputs =
            o.checkInputs
            ++ [
              oself.tezos-test-helpers
            ];
        });

        tezos-alpha = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "alpha";
          ocamlPackages = oself;
        };

        tezos-protocol-environment = osuper.tezos-protocol-environment.overrideAttrs (o: {
          propagatedBuildInputs = with oself; [
            tezos-stdlib
            tezos-crypto
            tezos-crypto-dal
            tezos-lwt-result-stdlib
            tezos-scoru-wasm

            data-encoding
            bls12-381
            tezos-plonk
            zarith
            zarith_stubs_js
            class_group_vdf
            ringo
            aches-lwt

            tezos-base
            tezos-sapling
            tezos-micheline
            tezos-context
            tezos-event-logging
          ];
        });
        tezos-proxy = osuper.tezos-proxy.overrideAttrs (o: {
          propagatedBuildInputs = with oself; [tezos-mockup-proxy tezos-context];
        });
        tezos-store = osuper.tezos-store.overrideAttrs (o: {
          propagatedBuildInputs = with oself; [
            index
            camlzip
            tar-unix
            digestif
            lwt-watcher
            tezos-protocol-updater
            tezos-validation
            prometheus
          ];
        });
        tezos-clic = osuper.tezos-clic.overrideAttrs (o: {
          propagatedBuildInputs = with oself; [tezos-lwt-result-stdlib tezos-stdlib-unix tezos-error-monad];
        });
        tezos-stdlib-unix = osuper.tezos-stdlib-unix.overrideAttrs (o: {
          checkInputs = with oself; [alcotest-lwt qcheck-alcotest];
        });
      }))
    prev.ocaml-ng;
}
