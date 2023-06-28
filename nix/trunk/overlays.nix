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

        rlp = oself.buildOasisPackage rec {
          pname = "rlp";
          version = "0.1";
          src = prev.fetchFromGitHub {
            owner = "pirapira";
            repo = "rlp-ocaml";
            rev = version;
            sha256 = "sha256-eCeEZCwzc5sosQImcJjKt1li+KmWzU+0neXCcZF4xqk=";
          };

          propagatedBuildInputs = with oself; [
            rope
            hex
            num
          ];

          doCheck = true;

          checkInputs = [oself.ounit];
        };

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

        tezos-alpha = oself.callPackage ./tezos/generic-protocol.nix {
          protocol-name = "alpha";
          ocamlPackages = oself;
        };

        tezos-017-PtNairob = oself.callPackage ./tezos/generic-protocol.nix {
          protocol-name = "017-PtNairob";
          ocamlPackages = oself;
        };

        tezos-018-Proxford = oself.callPackage ./tezos/generic-protocol.nix {
          protocol-name = "018-Proxford";
          ocamlPackages = oself;
        };
      }))
    prev.ocaml-ng;
}
