{
  octez_version,
  src,
}: final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: let
        inherit (oself) callPackage;
        disable_tests = package:
          package.overrideAttrs (_: {
            doCheck = false;
          });
      in {
        data-encoding = osuper.data-encoding.overrideAttrs (_: rec {
          version = "0.7.1";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "data-encoding";
            rev = "v${version}";
            sha256 = "sha256-V3XiCCtoU+srOI+KVSJshtaSJLBJ4m4o10GpBfdYKCU=";
          };
        });

        bls12-381-hash = oself.buildDunePackage rec {
          pname = "bls12-381-hash";
          version = "1.0.0";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "cryptography/ocaml-bls12-381-hash";
            rev = "${version}";
            sha256 = "sha256-cfsSVmN4rbKcLcPcy6NduZktJhPXiVdK75LypmaSe9I=";
          };

          propagatedBuildInputs = [oself.bls12-381];
        };

        tezos-bls12-381-polynomial = osuper.tezos-bls12-381-polynomial.overrideAttrs (o: rec {
          version = "1.0.1";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "cryptography/privacy-team";
            rev = "v${version}";
            sha256 = "sha256-5qDa/fQoTypjaceQ0MBzt0rM+0hSJcpGlXMGAZKRboo=";
          };

          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.ppx_repr];
        });

        polynomial = oself.buildDunePackage rec {
          pname = "polynomial";
          version = "0.4.0";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "cryptography/ocaml-polynomial";
            rev = version;
            sha256 = "sha256-is/PrYLCwStHiQsNq5OVRCwHdXjO2K2Z7FrXgytRfAU=";
          };

          propagatedBuildInputs = with oself; [zarith ff-sig];
        };

        tezos-plompiler = osuper.tezos-plompiler.overrideAttrs (o: rec {
          propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [polynomial bls12-381-hash]);
        });

        hacl-star-raw = callPackage ./hacl-star-raw.nix {};

        hacl-star = osuper.hacl-star.overrideAttrs (_: {
          buildInputs = [oself.alcotest];
        });

        ringo = osuper.ringo.overrideAttrs (_: rec {
          version = "1.0.0";
          src = final.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "ringo";
            rev = "v${version}";
            sha256 = "sha256-9HW3M27BxrEPbF8cMHwzP8FmJduUInpQQAE2672LOuU=";
          };

          checkPhase = "dune build @test/ringo/runtest";
        });

        aches = oself.buildDunePackage {
          pname = "aches";
          inherit (oself.ringo) src version;

          propagatedBuildInputs = [
            oself.ringo
          ];
        };

        aches-lwt = oself.buildDunePackage {
          pname = "aches-lwt";
          inherit (oself.ringo) src version;

          propagatedBuildInputs = [
            oself.aches
            oself.lwt
          ];
        };

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

          meta = {inherit (oself.ocaml.meta) platforms;};
        };

        prometheus = oself.buildDunePackage rec {
          version = "1.2";
          pname = "prometheus";
          src = final.fetchurl {
            url = "https://github.com/mirage/prometheus/releases/download/v${version}/prometheus-${version}.tbz";
            sha256 = "sha256-g2Q6ApprbecdFANO7i6U/v8dCHVcSkHVg9wVMKtVW8s=";
          };

          duneVersion = "3";

          propagatedBuildInputs = with oself; [
            astring
            asetmap
            fmt
            re
            lwt
            alcotest
          ];

          meta = {inherit (oself.ocaml.meta) platforms;};
        };

        prometheus-app = oself.buildDunePackage rec {
          pname = "prometheus-app";
          inherit (oself.prometheus) src version;

          duneVersion = "3";

          propagatedBuildInputs = with oself; [
            logs
            fmt
            cohttp
            cohttp-lwt-unix
            cmdliner
            prometheus
          ];

          meta = {inherit (oself.ocaml.meta) platforms;};
        };

        tezos-layer2-utils-alpha = callPackage ./tezos/layer2-utils-alpha.nix {};
        tezos-lazy-containers = oself.callPackage ./tezos/lazy-containers.nix {};
        tezos-tree-encoding = oself.callPackage ./tezos/tree-encoding.nix {};
        tezos-crypto-dal = oself.callPackage ./tezos/crypto-dal.nix {};

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
        tezos-015-PtLimaPt = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "015-PtLimaPt";
          ocamlPackages = oself;
        };
        tezos-016-PtMumbai = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "016-PtMumbai";
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
        octez-node-config = callPackage ./tezos/node-config.nix {};
        tezos-p2p-services = callPackage ./tezos/p2p-services.nix {};
        tezos-p2p = callPackage ./tezos/p2p.nix {};
        octez-protocol-compiler = callPackage ./tezos/protocol-compiler.nix {};
        tezos-protocol-demo-noops =
          callPackage ./tezos/protocol-demo-noops.nix {};
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
        tezos-store = callPackage ./tezos/store.nix {};
        tezos-validation = callPackage ./tezos/validation.nix {};
        tezos-version = callPackage ./tezos/version.nix {};
        tezos-webassembly-interpreter = callPackage ./tezos/webassembly-interpreter.nix {};
        tezos-workers = callPackage ./tezos/workers.nix {};
      }))
    prev.ocaml-ng;
}
