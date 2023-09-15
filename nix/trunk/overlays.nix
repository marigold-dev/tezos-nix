final: prev: {
  ocaml-ng =
    builtins.mapAttrs
      (ocamlVersion: curr_ocaml:
        curr_ocaml.overrideScope' (oself: osuper: {
          lwt = osuper.lwt.overrideAttrs (_o: rec {
            version = "5.7.0";

            src = final.fetchFromGitHub {
              owner = "ocsigen";
              repo = "lwt";
              rev = version;
              sha256 = "sha256-o0wPK6dPdnsr/LzwcSwbIGcL85wkDjdFuEcAxuS/UEs=";
            };
          });

          # New pacakges
          tezt-ethereum = oself.callPackage ./tezt/tezt-ethereum.nix { };
          tezt-tezos = oself.callPackage ./tezt/tezt-tezos.nix { };

          octez-l2-libs = oself.callPackage ./octez/l2-libs.nix { };
          octez-proto-libs = oself.callPackage ./octez/proto-libs.nix { };
          octez-shell-libs = oself.callPackage ./octez/shell-libs.nix { };
          octez-node-config = oself.callPackage ./octez/node-config.nix { };
          octez-smart-rollup-node-lib = oself.callPackage ./octez/smart-rollup-node-lib.nix { };
          octez-evm-proxy-lib-dev = oself.callPackage ./octez/evm-proxy-lib-dev.nix { };
          octez-evm-proxy-lib-prod = oself.callPackage ./octez/evm-proxy-lib-prod.nix { };

          # Overrides
          tezos-dac-client-lib = oself.callPackage ./tezos/dac-client-lib.nix { };
          tezos-dac-node-lib = oself.callPackage ./tezos/dac-node-lib.nix { };
          tezos-dac-lib = oself.callPackage ./tezos/dac-lib.nix { };
          tezos-dal-node-lib = oself.callPackage ./tezos/dal-node-lib.nix { };
          tezos-micheline-rewriting = oself.callPackage ./tezos/micheline-rewriting.nix { };

          octez-crawler = oself.callPackage ./octez/crawler.nix { };
          octez-injector = oself.callPackage ./octez/injector.nix { };
          octez-protocol-compiler = oself.callPackage ./octez/protocol-compiler.nix { };

          tezos-000-Ps9mPmXa = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "000-Ps9mPmXa";
            ocamlPackages = oself;
          };
          tezos-001-PtCJ7pwo = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "001-PtCJ7pwo";
            ocamlPackages = oself;
          };
          tezos-002-PsYLVpVv = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "002-PsYLVpVv";
            ocamlPackages = oself;
          };
          tezos-003-PsddFKi3 = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "003-PsddFKi3";
            ocamlPackages = oself;
          };
          tezos-004-Pt24m4xi = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "004-Pt24m4xi";
            ocamlPackages = oself;
          };
          tezos-005-PsBABY5H = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "005-PsBABY5H";
            ocamlPackages = oself;
          };
          tezos-005-PsBabyM1 = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "005-PsBabyM1";
            ocamlPackages = oself;
          };
          tezos-006-PsCARTHA = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "006-PsCARTHA";
            ocamlPackages = oself;
          };
          tezos-007-PsDELPH1 = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "007-PsDELPH1";
            ocamlPackages = oself;
          };
          tezos-008-PtEdo2Zk = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "008-PtEdo2Zk";
            ocamlPackages = oself;
          };
          tezos-009-PsFLoren = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "009-PsFLoren";
            ocamlPackages = oself;
          };
          tezos-010-PtGRANAD = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "010-PtGRANAD";
            ocamlPackages = oself;
          };
          tezos-011-PtHangz2 = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "011-PtHangz2";
            ocamlPackages = oself;
          };
          tezos-012-Psithaca = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "012-Psithaca";
            ocamlPackages = oself;
          };
          tezos-013-PtJakart = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "013-PtJakart";
            ocamlPackages = oself;
          };
          tezos-014-PtKathma = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "014-PtKathma";
            ocamlPackages = oself;
          };
          tezos-015-PtLimaPt = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "015-PtLimaPt";
            ocamlPackages = oself;
          };
          tezos-016-PtMumbai = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "016-PtMumbai";
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
          tezos-alpha = oself.callPackage ./tezos/generic-protocol.nix {
            protocol-name = "alpha";
            ocamlPackages = oself;
          };
        }))
      prev.ocaml-ng;
}
