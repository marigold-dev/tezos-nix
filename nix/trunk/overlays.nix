final: prev: {
  tezos-rust-libs = final.stdenv.mkDerivation rec {
    version = "1.5";
    pname = "tezos-rust-libs";
    src = prev.fetchFromGitLab {
      owner = "tezos";
      repo = "tezos-rust-libs";
      rev = "v${version}";
      sha256 = "sha256-SuCqDZDXmWdGI/GN+3nYcUk66jnW5FQQaeTB76/rvaw=";
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
  };
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: let
        inherit (oself) callPackage;
      in {
        ezjsonm = osuper.ezjsonm.overrideAttrs (_: rec {
          version = "1.3.0";
          src = final.fetchurl {
            url = "https://github.com/mirage/ezjsonm/releases/download/v${version}/ezjsonm-${version}.tbz";
            sha256 = "sha256-CGM+Dw52eoroGTXKfnTxaTuFp5xFAtVo7t/1Fw8M13s=";
          };
        });

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

        tezos-benchmark = callPackage ./tezos/benchmark.nix {};
        tezos-benchmark-examples = callPackage ./tezos/benchmark-examples.nix {};

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

        tezt-tezos = callPackage ./tezos/tezt-tezos.nix {};
        tezt-performance-regression = callPackage ./tezos/tezt-performance-regression.nix {};

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
