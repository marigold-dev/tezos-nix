final: prev:
let
  version = "12.3";
  src = final.fetchFromGitLab {
    owner = "tezos";
    repo = "tezos";
    rev = "v${version}";
    sha256 = "sha256-j0phPzuj9FLfMyqwMuUeolYQLh2eF3CY9XHSScqgQnk=";
  };
in {
  ocaml-ng = builtins.mapAttrs (ocamlVersion: curr_ocaml:
    curr_ocaml.overrideScope' (oself: osuper:
      let callPackage = final.ocaml-ng.${ocamlVersion}.callPackage;
      in {
        hacl-star-raw = osuper.hacl-star-raw.overrideAttrs
          (_: { hardeningDisable = [ "strictoverflow" ]; });

        pure-splitmix = oself.buildDunePackage rec {
          pname = "pure-splitmix";
          version = "0.3";

          src = final.fetchFromGitHub {
            owner = "Lysxia";
            repo = pname;
            rev = version;
            sha256 = "RUnsAB4hMV87ItCyGhc47bHGY1iOwVv9kco2HxnzqbU=";
          };

          doCheck = true;

          meta = { platforms = oself.ocaml.meta.platforms; };
        };

        json-data-encoding = osuper.json-data-encoding.overrideAttrs (o: rec {
          meta = { platforms = oself.ocaml.meta.platforms; };
        });

        json-data-encoding-bson = osuper.json-data-encoding-bson.overrideAttrs
          (o: rec {
            meta = { platforms = oself.ocaml.meta.platforms; };
          });

        data-encoding = osuper.data-encoding.overrideAttrs (o: rec {
          meta = { platforms = oself.ocaml.meta.platforms; };
        });
        tezos-genesis-carthagenet = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "genesis-carthagenet";
        };
        tezos-demo-counter = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "demo-counter";
        };
        tezos-demo-noops = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "demo-noops";
        };
        tezos-000-Ps9mPmXa = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "000-Ps9mPmXa";
        };
        tezos-001-PtCJ7pwo = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "001-PtCJ7pwo";
        };
        tezos-002-PsYLVpVv = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "002-PsYLVpVv";
        };
        tezos-003-PsddFKi3 = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "003-PsddFKi3";
        };
        tezos-004-Pt24m4xi = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "004-Pt24m4xi";
        };
        tezos-005-PsBABY5H = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "005-PsBABY5H";
        };
        tezos-005-PsBabyM1 = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "005-PsBabyM1";
        };
        tezos-006-PsCARTHA = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "006-PsCARTHA";
        };
        tezos-007-PsDELPH1 = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "007-PsDELPH1";
        };
        tezos-008-PtEdo2Zk = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "008-PtEdo2Zk";
        };
        tezos-009-PsFLoren = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "009-PsFLoren";
        };
        tezos-010-PtGRANAD = callPackage ./tezos/generic-protocol.nix { protocol-name = "010-PtGRANAD"; };
        tezos-011-PtHangz2 = callPackage ./tezos/generic-protocol.nix { protocol-name = "011-PtHangz2"; };
        tezos-012-Psithaca = callPackage ./tezos/generic-protocol.nix { protocol-name = "012-Psithaca"; };
        tezos-alpha = callPackage ./tezos/generic-protocol.nix { protocol-name = "alpha"; };

        tezos-base = callPackage ./tezos/base.nix { };
        tezos-clic = callPackage ./tezos/clic.nix { };
        tezos-client-base = callPackage ./tezos/client-base.nix { };
        tezos-client-base-unix = callPackage ./tezos/client-base-unix.nix { };
        tezos-client-commands = callPackage ./tezos/client-commands.nix { };
        tezos-context = callPackage ./tezos/context.nix { };
        tezos-crypto = callPackage ./tezos/crypto.nix { };

        tezos-genesis =
          callPackage ./tezos/generic-protocol.nix { protocol-name = "genesis"; };
        
        tezos-error-monad = callPackage ./tezos/error-monad.nix { };
        tezos-event-logging = callPackage ./tezos/event-logging.nix { };
        tezos-event-logging-test-helpers =
          callPackage ./tezos/event-logging-test-helpers.nix { };
        tezos-legacy-store = callPackage ./tezos/legacy-store.nix { };
        tezos-lmdb = callPackage ./tezos/lmdb.nix { };
        tezos-hacl-glue = callPackage ./tezos/hacl-glue.nix { };
        tezos-hacl-glue-unix = callPackage ./tezos/hacl-glue-unix.nix { };
        tezos-lwt-result-stdlib = callPackage ./tezos/lwt-result-stdlib.nix { };
        tezos-micheline = callPackage ./tezos/micheline.nix { };
        tezos-mockup-commands = callPackage ./tezos/mockup-commands.nix { };
        tezos-mockup-proxy = callPackage ./tezos/mockup-proxy.nix { };
        tezos-mockup-registration =
          callPackage ./tezos/mockup-registration.nix { };
        tezos-mockup = callPackage ./tezos/mockup.nix { };
        tezos-p2p-services = callPackage ./tezos/p2p-services.nix { };
        tezos-p2p = callPackage ./tezos/p2p.nix { };
        tezos-protocol-compiler = callPackage ./tezos/protocol-compiler.nix { };
        tezos-protocol-demo-noops =
          callPackage ./tezos/protocol-demo-noops.nix { };
        tezos-protocol-environment-packer =
          callPackage ./tezos/protocol-environment-packer.nix { };
        tezos-protocol-environment-sigs =
          callPackage ./tezos/protocol-environment-sigs.nix { };
        tezos-protocol-environment-structs =
          callPackage ./tezos/protocol-environment-structs.nix { };
        tezos-protocol-environment =
          callPackage ./tezos/protocol-environment.nix { };
        tezos-protocol-updater = callPackage ./tezos/protocol-updater.nix { };
        tezos-proxy = callPackage ./tezos/proxy.nix { };
        tezos-requester = callPackage ./tezos/requester.nix { };
        tezos-rpc-http-client-unix =
          callPackage ./tezos/rpc-http-client-unix.nix { };
        tezos-rpc-http-client = callPackage ./tezos/rpc-http-client.nix { };
        tezos-rpc-http-server = callPackage ./tezos/rpc-http-server.nix { };
        tezos-rpc-http = callPackage ./tezos/rpc-http.nix { };
        tezos-rpc = callPackage ./tezos/rpc.nix { };
        tezos-sapling = callPackage ./tezos/sapling.nix { };
        tezos-shell-context = callPackage ./tezos/shell-context.nix { };
        tezos-shell-services = callPackage ./tezos/shell-services.nix { };
        tezos-shell-services-test-helpers =
          callPackage ./tezos/shell-services-test-helpers.nix { };
        tezos-shell = callPackage ./tezos/shell.nix { };
        tezos-signer-backends = callPackage ./tezos/signer-backends.nix { };
        tezos-signer-services = callPackage ./tezos/signer-services.nix { };
        tezos-stdlib-unix = callPackage ./tezos/stdlib-unix.nix { };
        tezos-stdlib = callPackage ./tezos/stdlib.nix { inherit src version; };
        tezos-test-helpers = callPackage ./tezos/test-helpers.nix { };
        tezos-store = callPackage ./tezos/store.nix { };
        tezos-validation = callPackage ./tezos/validation.nix { };
        tezos-validator = callPackage ./tezos/validator.nix { };
        tezos-version = callPackage ./tezos/version.nix { };
        tezos-workers = callPackage ./tezos/workers.nix { };
      })) prev.ocaml-ng;
}
