{
  octez_version,
  src,
}: final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: let
        callPackage = oself.callPackage;
        disable_tests = package:
          package.overrideAttrs (_: {
            doCheck = false;
          });
      in {
        alcotest = disable_tests osuper.alcotest;

        asetmap = final.stdenv.mkDerivation rec {
          version = "0.8.1";
          pname = "asetmap";
          src = final.fetchurl {
            url = "https://github.com/dbuenzli/asetmap/archive/refs/tags/v0.8.1.tar.gz";
            sha256 = "051ky0k62xp4inwi6isif56hx5ggazv4jrl7s5lpvn9cj8329frj";
          };

          strictDeps = true;

          nativeBuildInputs = with oself; [topkg findlib ocamlbuild ocaml];
          buildInputs = with oself; [topkg];

          inherit (oself.topkg) buildPhase installPhase;

          meta = {platforms = oself.ocaml.meta.platforms;};
        };

        prometheus = oself.buildDunePackage rec {
          version = "1.2";
          pname = "prometheus";
          src = final.fetchurl {
            url = "https://github.com/mirage/prometheus/releases/download/v${version}/prometheus-${version}.tbz";
            sha256 = "sha256-g2Q6ApprbecdFANO7i6U/v8dCHVcSkHVg9wVMKtVW8s=";
          };

          strictDeps = true;

          propagatedBuildInputs = with oself; [
            astring
            asetmap
            fmt
            re
            lwt
            alcotest
          ];

          meta = {platforms = oself.ocaml.meta.platforms;};
        };

        prometheus-app = oself.buildDunePackage rec {
          pname = "prometheus-app";
          inherit (oself.prometheus) src version;

          strictDeps = true;

          propagatedBuildInputs = with oself; [
            logs
            fmt
            cohttp
            cohttp-lwt-unix
            cmdliner
            prometheus
          ];

          meta = {platforms = oself.ocaml.meta.platforms;};
        };

        ptime = osuper.ptime.overrideAttrs (o: rec {
          version = "1.0.0";
          src = final.fetchurl {
            url = "https://erratique.ch/software/ptime/releases/ptime-1.0.0.tbz";
            sha256 = "02qiwafysw5vpbxmkhgf6hfr5fv967rxzfkfy18kgj3206686724";
          };

          buildPhase = "${oself.topkg.run} build";
        });

        ometrics = oself.buildDunePackage rec {
          pname = "ometrics";
          version = "0.2.1";

          src = final.fetchurl {
            url = "https://github.com/vch9/ometrics/archive/${version}.tar.gz";
            sha256 = "sha256-RFvlYiYXhJ0m3RCfWfFOYvwEN7vrM9hPCG6gRU0KlHw=";
          };

          buildInputs = with oself; [
            ppxlib
            cmdliner
            digestif
          ];

          checkInputs = [oself.qcheck-alcotest];

          doCheck = false;

          meta = {platforms = oself.ocaml.meta.platforms;};
        };

        tezos-genesis = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "genesis";
          ocamlPackages = oself;
        };
        tezos-genesis-carthagenet = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "genesis-carthagenet";
          ocamlPackages = oself;
        };
        tezos-demo-counter = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "demo-counter";
          ocamlPackages = oself;
        };
        tezos-demo-noops = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "demo-noops";
          ocamlPackages = oself;
        };
        tezos-000-Ps9mPmXa = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "000-Ps9mPmXa";
          ocamlPackages = oself;
        };
        tezos-001-PtCJ7pwo = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "001-PtCJ7pwo";
          ocamlPackages = oself;
        };
        tezos-002-PsYLVpVv = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "002-PsYLVpVv";
          ocamlPackages = oself;
        };
        tezos-003-PsddFKi3 = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "003-PsddFKi3";
          ocamlPackages = oself;
        };
        tezos-004-Pt24m4xi = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "004-Pt24m4xi";
          ocamlPackages = oself;
        };
        tezos-005-PsBABY5H = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "005-PsBABY5H";
          ocamlPackages = oself;
        };
        tezos-005-PsBabyM1 = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "005-PsBabyM1";
          ocamlPackages = oself;
        };
        tezos-006-PsCARTHA = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "006-PsCARTHA";
          ocamlPackages = oself;
        };
        tezos-007-PsDELPH1 = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "007-PsDELPH1";
          ocamlPackages = oself;
        };
        tezos-008-PtEdo2Zk = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "008-PtEdo2Zk";
          ocamlPackages = oself;
        };
        tezos-009-PsFLoren = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "009-PsFLoren";
          ocamlPackages = oself;
        };
        tezos-010-PtGRANAD = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "010-PtGRANAD";
          ocamlPackages = oself;
        };
        tezos-011-PtHangz2 = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "011-PtHangz2";
          ocamlPackages = oself;
        };
        tezos-012-Psithaca = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "012-Psithaca";
          ocamlPackages = oself;
        };
        tezos-013-PtJakart = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "013-PtJakart";
          ocamlPackages = oself;
        };
        tezos-014-PtKathma = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "014-PtKathma";
          ocamlPackages = oself;
        };
        tezos-alpha = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "alpha";
          ocamlPackages = oself;
        };

        tezos-base = callPackage ./tezos/base.nix {};
        tezos-base-test-helpers =
          callPackage ./tezos/base-test-helpers.nix {};
        tezos-clic = callPackage ./tezos/clic.nix {};
        tezos-client-base = callPackage ./tezos/client-base.nix {};
        tezos-client-base-unix = callPackage ./tezos/client-base-unix.nix {};
        tezos-client-commands = callPackage ./tezos/client-commands.nix {};
        tezos-context-ops = callPackage ./tezos/context-ops.nix {};
        tezos-context = callPackage ./tezos/context.nix {};
        tezos-crypto = callPackage ./tezos/crypto.nix {};

        tezos-error-monad = callPackage ./tezos/error-monad.nix {};
        tezos-event-logging = callPackage ./tezos/event-logging.nix {};
        tezos-event-logging-test-helpers =
          callPackage ./tezos/event-logging-test-helpers.nix {};
        tezos-legacy-store = callPackage ./tezos/legacy-store.nix {};
        tezos-lmdb = callPackage ./tezos/lmdb.nix {};
        tezos-hacl = callPackage ./tezos/hacl.nix {};
        tezos-hacl-glue = callPackage ./tezos/hacl-glue.nix {};
        tezos-hacl-glue-unix = callPackage ./tezos/hacl-glue-unix.nix {};
        tezos-lwt-result-stdlib = callPackage ./tezos/lwt-result-stdlib.nix {};
        tezos-micheline = callPackage ./tezos/micheline.nix {};
        tezos-mockup-commands = callPackage ./tezos/mockup-commands.nix {};
        tezos-mockup-proxy = callPackage ./tezos/mockup-proxy.nix {};
        tezos-mockup-registration =
          callPackage ./tezos/mockup-registration.nix {};
        tezos-mockup = callPackage ./tezos/mockup.nix {};
        tezos-p2p-services = callPackage ./tezos/p2p-services.nix {};
        tezos-p2p = callPackage ./tezos/p2p.nix {};
        tezos-protocol-compiler = callPackage ./tezos/protocol-compiler.nix {};
        tezos-protocol-demo-noops =
          callPackage ./tezos/protocol-demo-noops.nix {};
        tezos-protocol-environment-packer =
          callPackage ./tezos/protocol-environment-packer.nix {};
        tezos-protocol-environment-sigs =
          callPackage ./tezos/protocol-environment-sigs.nix {};
        tezos-protocol-environment-structs =
          callPackage ./tezos/protocol-environment-structs.nix {};
        tezos-protocol-environment =
          callPackage ./tezos/protocol-environment.nix {};
        tezos-protocol-updater = callPackage ./tezos/protocol-updater.nix {};
        tezos-proxy = callPackage ./tezos/proxy.nix {};
        tezos-requester = callPackage ./tezos/requester.nix {};
        tezos-rpc-http-client-unix =
          callPackage ./tezos/rpc-http-client-unix.nix {};
        tezos-rpc-http-client = callPackage ./tezos/rpc-http-client.nix {};
        tezos-rpc-http-server = callPackage ./tezos/rpc-http-server.nix {};
        tezos-rpc-http = callPackage ./tezos/rpc-http.nix {};
        tezos-rpc = callPackage ./tezos/rpc.nix {};
        tezos-sapling = callPackage ./tezos/sapling.nix {};
        tezos-scoru-wasm = callPackage ./tezos/scoru-wasm.nix {};
        tezos-shell-context = callPackage ./tezos/shell-context.nix {};
        tezos-shell-services = callPackage ./tezos/shell-services.nix {};
        tezos-shell-services-test-helpers =
          callPackage ./tezos/shell-services-test-helpers.nix {};
        tezos-shell = callPackage ./tezos/shell.nix {};
        tezos-signer-backends = callPackage ./tezos/signer-backends.nix {};
        tezos-signer-services = callPackage ./tezos/signer-services.nix {};
        tezos-stdlib-unix = callPackage ./tezos/stdlib-unix.nix {};
        tezos-stdlib = callPackage ./tezos/stdlib.nix {
          inherit src;
          version = octez_version;
        };
        tezos-test-helpers = callPackage ./tezos/test-helpers.nix {};
        tezos-test-helpers-extra = callPackage ./tezos/test-helpers-extra.nix {};
        tezos-tooling = callPackage ./tezos/tooling.nix {};
        tezos-tx-rollup-alpha = callPackage ./tezos/tx-rollup-alpha.nix {};
        tezos-store = callPackage ./tezos/store.nix {};
        tezos-validation = callPackage ./tezos/validation.nix {};
        tezos-validator = callPackage ./tezos/validator.nix {};
        tezos-version = callPackage ./tezos/version.nix {};
        tezos-webassembly-interpreter = callPackage ./tezos/webassembly-interpreter.nix {};
        tezos-workers = callPackage ./tezos/workers.nix {};
      }))
    prev.ocaml-ng;
}
