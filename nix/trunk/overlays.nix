final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: {
        ppx_irmin = osuper.ppx_irmin.overrideAttrs (o: rec {
          version = "3.7.2";

          src = prev.fetchurl {
            url = "https://github.com/mirage/irmin/releases/download/${version}/irmin-${version}.tbz";
            hash = "sha256-aqW6TGoCM3R9S9OrOW8rOjO7gPnY7UoXjIOgNQM8DlI=";
          };
        });

        # New pacakges

        tezt-ethereum = oself.callPackage ./tezt/tezt-ethereum.nix {};

        octez-smart-rollup = oself.callPackage ./octez/octez-smart-rollup.nix {};

        octez-evm-proxy-lib = oself.callPackage ./octez/octez-evm-proxy-lib.nix {};

        # Overrides
        tezos-dal-node-lib = osuper.tezos-dal-node-lib.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.tezos-gossipsub];
        });

        octez-smart-rollup-node = osuper.octez-smart-rollup-node.overrideAttrs (o: {
          propagatedBuildInputs =
            o.propagatedBuildInputs
            ++ (with oself; [
              tezos-layer2-store
              tezos-client-base-unix
              octez-smart-rollup
            ]);
        });

        tezos-p2p = osuper.tezos-p2p.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.tezt];
        });

        tezos-shell-services = osuper.tezos-shell-services.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.tezos-crypto-dal];
        });

        tezos-alpha =
          osuper.tezos-alpha
          // {
            smart-rollup-layer2 = osuper.tezos-alpha.smart-rollup-layer2.overrideAttrs (o: {
              propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.octez-smart-rollup];
            });
          };

        tezos-017-PtNairob =
          osuper.tezos-017-PtNairob
          // {
            smart-rollup-layer2 = osuper.tezos-017-PtNairob.smart-rollup-layer2.overrideAttrs (o: {
              propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.octez-smart-rollup];
            });
          };
      }))
    prev.ocaml-ng;
}
