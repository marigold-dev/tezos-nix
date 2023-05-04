final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: {
        tezos-event-logging-test-helpers = osuper.tezos-event-logging-test-helpers.overrideAttrs (o: rec {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.octez-alcotezt];
        });

        tezos-lwt-result-stdlib = osuper.tezos-lwt-result-stdlib.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-error-monad = osuper.tezos-error-monad.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-hacl = osuper.tezos-hacl.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-clic = osuper.tezos-clic.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-signer-backends = osuper.tezos-signer-backends.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-client-base = osuper.tezos-client-base.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-protocol-environment = osuper.tezos-protocol-environment.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-context = osuper.tezos-context.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-version = osuper.tezos-version.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-crypto-dal = osuper.tezos-crypto-dal.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-shell-services = osuper.tezos-shell-services.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-webassembly-interpreter = osuper.tezos-webassembly-interpreter.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-layer2-store = osuper.tezos-layer2-store.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-micheline-rewriting = osuper.tezos-micheline-rewriting.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-proxy-server-config = osuper.tezos-proxy-server-config.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt];
        });

        tezos-stdlib-unix = osuper.tezos-stdlib-unix.overrideAttrs (o: rec {
          checkInputs = o.checkInputs ++ [oself.tezt oself.octez-alcotezt oself.tezos-test-helpers];
        });
      }))
    prev.ocaml-ng;
}
