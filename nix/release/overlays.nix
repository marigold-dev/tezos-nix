{
  octez_version,
  src,
}: final: prev: {
  zcash-params = prev.callPackage ./zcash.nix {};
  tezos-rust-libs = prev.tezos-rust-libs.overrideAttrs (drv: rec {
    version = "1.4";
    name = "${drv.pname}-${version}";
    src = prev.fetchFromGitLab {
      owner = "tezos";
      repo = "tezos-rust-libs";
      rev = "v${version}";
      sha256 = "sha256-SYfSRpBzsnBsB62rdhurghUmufMHyC8ZRvpynxPQCWY=";
    };

    nativeBuildInputs = [final.llvmPackages_12.llvm final.cargo];
    propagatedBuildDeps = [final.llvmPackages_12.libllvm];

    preInstall = ''
      mkdir -p $out/lib/tezos-rust-libs
      mkdir -p $out/lib/tezos-rust-libs/rust
    '';

    preBuild = null;

    buildPhase = ''
      cargo build \
        --target-dir target-librustzcash \
        --package librustzcash \
        --release

      cargo build \
        --target-dir target-wasmer \
        --package wasmer-c-api \
        --no-default-features \
        --features singlepass,cranelift,wat,middlewares,universal \
        --release
    '';

    installPhase = ''
      mkdir -p $out/lib/tezos-rust-libs/rust
      cp "librustzcash/include/librustzcash.h" \
          "target-librustzcash/release/librustzcash.a" \
          "wasmer-2.3.0/lib/c-api/wasm.h" \
          "wasmer-2.3.0/lib/c-api/wasmer.h" \
          "target-wasmer/release/libwasmer.a" \
          "$out/lib/tezos-rust-libs"
      cp -r "librustzcash/include/rust" "$out/lib/tezos-rust-libs"
    '';

    cargoVendorDir = "./vendor";
  });
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
        tls = osuper.tls.overrideAttrs (_: rec {
          version = "0.16.0";
          src = final.fetchurl {
            url = "https://github.com/mirleft/ocaml-tls/releases/download/v${version}/tls-${version}.tbz";
            sha256 = "sha256-uvIDZLNy6E/ce7YmzUUVaOeGRaHqPSUzuEPQDMu09tM=";
          };
        });

        tls-lwt = oself.buildDunePackage rec {
          inherit (oself.tls) version src;
          pname = "tls-lwt";

          duneVersion = "3";

          propagatedBuildInputs = with oself; [
            tls
            lwt
            mirage-crypto-rng-lwt
            x509
            cmdliner
          ];
        };

        /*
        ctypes-foreign = oself.buildDunePackage rec {
        version = "0.18.0";
        src = final.fetchFromGitHub {
        owner = "yallop";
        repo = "ocaml-ctypes";
        rev = "${version}";
        sha256 = "sha256-eu5RAuPYC97IM4XUsUw3HQ1BJlEHQ+eBpsdUE6hd+Q8=";
        };
        pname = "ctypes-foreign";

        duneVersion = "3";

        propagatedBuildInputs = with oself; [
        ctypes
        final.libffi
        ];

        nativeBuildInputs = [ final.pkg-config ];
        };
        */

        ezjsonm = osuper.ezjsonm.overrideAttrs (_: rec {
          version = "1.3.0";
          src = final.fetchurl {
            url = "https://github.com/mirage/ezjsonm/releases/download/v${version}/ezjsonm-${version}.tbz";
            sha256 = "sha256-CGM+Dw52eoroGTXKfnTxaTuFp5xFAtVo7t/1Fw8M13s=";
          };
        });

        seqes = osuper.buildDunePackage rec {
          pname = "seqes";
          version = "0.2";
          src = final.fetchurl {
            url = "https://gitlab.com/nomadic-labs/seqes/-/archive/${version}/seqes-${version}.tar.gz";
            sha256 = "sha256-IxLA0jaIPdX9Zn/GL8UHDJYjA1UBW6leGbZmp64YMjI=";
          };

          duneVersion = "3";

          checkInputs = with osuper; [qcheck qcheck-alcotest alcotest];
        };

        prbnmcn-linalg = oself.buildDunePackage rec {
          pname = "prbnmcn-linalg";
          version = "0.0.1";
          src = final.fetchFromGitHub {
            owner = "igarnier";
            repo = pname;
            rev = version;
            sha256 = "sha256-nr7W5TRkgTnkYEiWZIDcXcsUIswzDZf5CrhFu7kEAt0=";
          };

          propagatedBuildInputs = with oself; [prbnmcn-basic-structures];

          checkInputs = with oself; [crowbar prbnmcn-proptest];
        };

        prbnmcn-proptest = oself.buildDunePackage rec {
          pname = "prbnmcn-proptest";
          version = "0.0.1";
          src = final.fetchFromGitHub {
            owner = "igarnier";
            repo = pname;
            rev = version;
            sha256 = "sha256-nr7W5TRkgTnkYEiWZIDcXcsUIswzDZf5CrhFu7kEAt0=";
          };

          propagatedBuildInputs = with oself; [prbnmcn-basic-structures crowbar zarith];
        };

        prbnmcn-stats = oself.buildDunePackage rec {
          pname = "prbnmcn-stats";
          version = "0.0.4";
          src = final.fetchFromGitHub {
            owner = "igarnier";
            repo = pname;
            rev = version;
            sha256 = "sha256-DpmUvyOSV+yTKXXObq6MoqI4xIInund670qxCDDqBsE=";
          };

          propagatedBuildInputs = with oself; [prbnmcn-basic-structures prbnmcn-linalg];

          checkInputs = with oself; [qcheck ocamlgraph];
        };

        prbnmcn-cgrph = oself.buildDunePackage rec {
          pname = "prbnmcn-cgrph";
          version = "0.0.2";
          src = final.fetchFromGitHub {
            owner = "igarnier";
            repo = pname;
            rev = version;
            sha256 = "sha256-UFICImWjbuOUnjRWmWgtQ+yno1QFp3mX2d7U2EFA9HA=";
          };

          preBuild = "ls";

          checkInputs = with oself; [qcheck];
        };

        prbnmcn-dagger = oself.buildDunePackage rec {
          pname = "prbnmcn-dagger";
          version = "0.0.2";
          src = final.fetchFromGitHub {
            owner = "igarnier";
            repo = pname;
            rev = version;
            sha256 = "sha256-+xbw17jvGlvOCX2c3ZSfpQ0YY7EsOxRA1qMFmDPQn7Y=";
          };

          propagatedBuildInputs = with oself; [prbnmcn-cgrph pringo];
        };

        prbnmcn-dagger-stats = oself.buildDunePackage {
          pname = "prbnmcn-dagger-stats";
          inherit (oself.prbnmcn-dagger) version src;

          propagatedBuildInputs = with oself; [prbnmcn-dagger prbnmcn-stats];
        };

        prbnmcn-basic-structures = oself.buildDunePackage rec {
          pname = "prbnmcn-basic-structures";
          version = "0.0.1";
          src = final.fetchFromGitHub {
            owner = "igarnier";
            repo = pname;
            rev = version;
            sha256 = "sha256-0lcGsL+rrc13ZwfzfAneLwJVoi0MbPjOEhQiveexOco=";
          };

          propagatedBuildInputs = with oself; [zarith];
        };

        pringo = final.stdenv.mkDerivation rec {
          pname = "pringo";
          version = "1.3";
          src = final.fetchFromGitHub {
            owner = "xavierleroy";
            repo = pname;
            rev = version;
            sha256 = "sha256-DyW8hPAxyL9xV0JGWI/rFHiN+FiRnkUL6xSHhoafy44=";
          };

          nativeBuildInputs = with oself; [ocaml findlib];

          preInstall = ''
            mkdir -p $out/lib/ocaml/${oself.ocaml.version}/site-lib/${pname}
          '';

          doCheck = false;
        };

        tezt = oself.buildDunePackage rec {
          pname = "tezt";
          version = "3.0.0";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "tezt";
            rev = "${version}";
            sha256 = "sha256-C7mqOUmZ2h3J1Yee3Yx/EBqldYUgtf0BpoRx9EsdFVA=";
          };

          duneVersion = "3";

          nativeBuildInputs = with oself; [
            js_of_ocaml
          ];

          propagatedBuildInputs = with oself; [
            re
            lwt
            ezjsonm
            js_of_ocaml
            js_of_ocaml-lwt
          ];
        };

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

          duneVersion = "3";

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

        ff-sig = osuper.ff-sig.overrideAttrs (_: {
          duneVersion = "3";
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

          duneVersion = "3";

          propagatedBuildInputs = with oself; [zarith ff-sig];
        };

        tezos-plompiler = osuper.tezos-plompiler.overrideAttrs (o: rec {
          propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [polynomial bls12-381-hash]);
        });

        hacl-star-raw = callPackage ./hacl-star-raw.nix {};

        hacl-star = with oself;
          buildDunePackage {
            pname = "hacl-star";

            inherit (hacl-star-raw) version src meta doCheck minimalOCamlVersion;

            duneVersion = "3";

            propagatedBuildInputs = [
              hacl-star-raw
              zarith
            ];

            nativeBuildInputs = [
              cppo
            ];

            checkInputs = [
              alcotest
              secp256k1-internal
              qcheck-core
              cstruct
            ];
          };

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

        tezt-tezos = callPackage ./tezos/tezt-tezos.nix {};
        tezt-performance-regression = callPackage ./tezos/tezt-performance-regression.nix {};
        tezos-layer2-store = callPackage ./tezos/layer2-store.nix {};
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
        tezos-dal-node-services = callPackage ./tezos/dal-node-services.nix {};
        tezos-dal-node-lib = callPackage ./tezos/dal-node-lib.nix {};
        tezos-dal-016-PtMumbai = callPackage ./tezos/dal-016-PtMumbai.nix {};
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
        tezos-benchmark = callPackage ./tezos/benchmark.nix {};
        tezos-benchmark-examples = callPackage ./tezos/benchmark-examples.nix {};
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
        tezos-micheline-rewriting = callPackage ./tezos/micheline-rewriting.nix {};
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
        tezos-proxy-server-config = callPackage ./tezos/proxy-server-config.nix {};
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
        tezos-scoru-wasm-fast = callPackage ./tezos/scoru-wasm-fast.nix {};
        tezos-scoru-wasm-helpers = callPackage ./tezos/scoru-wasm-helpers.nix {};
        tezos-shell-benchmarks = callPackage ./tezos/shell-benchmarks.nix {};
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
        tezos-wasmer = callPackage ./tezos/wasmer.nix {};
        tezos-webassembly-interpreter = callPackage ./tezos/webassembly-interpreter.nix {};
        tezos-webassembly-interpreter-extra = callPackage ./tezos/webassembly-interpreter-extra.nix {};
        tezos-workers = callPackage ./tezos/workers.nix {};
      }))
    prev.ocaml-ng;
}
