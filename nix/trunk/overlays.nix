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

        tezos-p2p = osuper.tezos-p2p.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.tezt];
        });

        tezos-shell-services = osuper.tezos-shell-services.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.tezos-crypto-dal];
        });

        octez-evm-proxy-lib = oself.callPackage ./octez/octez-evm-proxy-lib.nix {};

        # Overrides
        tezos-dal-node-lib = osuper.tezos-dal-node-lib.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.tezos-gossipsub];
        });
      }))
    prev.ocaml-ng;
}
