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
      curr_ocaml.overrideScope' (oself: osuper: {
        bls12-381 = oself.callPackage ./bls12-381.nix {};
        tezos-protocol-environment = osuper.tezos-protocol-environment.overrideAttrs (o: {
          propagatedBuildInputs = with oself; [
            tezos-stdlib
            tezos-crypto
            tezos-crypto-dal
            tezos-lwt-result-stdlib
            tezos-scoru-wasm

            data-encoding
            bls12-381
            octez-plonk
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

        tezos-lazy-containers = oself.callPackage ./tezos/lazy-containers.nix {};
        tezos-tree-encoding = oself.callPackage ./tezos/tree-encoding.nix {};

        tezos-store = osuper.tezos-store.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.digestif];
        });

        tezos-lwt-result-stdlib = osuper.tezos-lwt-result-stdlib.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.seqes];
        });

        tezos-proxy = oself.callPackage ./tezos/proxy.nix {};
        tezos-crypto = oself.callPackage ./tezos/crypto.nix {};

        tezos-dac-lib = oself.callPackage ./tezos/dac-lib.nix {};
        tezos-dac-client-lib = oself.callPackage ./tezos/dac-client-lib.nix {};
        tezos-dac-node-lib = oself.callPackage ./tezos/dac-node-lib.nix {};

        tezos-crypto-dal = oself.callPackage ./tezos/crypto-dal.nix {};
        tezos-016-PtMumbai = oself.callPackage ./tezos/generic-protocol.nix {
          protocol-name = "016-PtMumbai";
          ocamlPackages = oself;
        };
        tezos-alpha = oself.callPackage ./tezos/generic-protocol.nix {
          protocol-name = "alpha";
          ocamlPackages = oself;
        };
        octez-alcotezt = oself.callPackage ./octez/octez-alcotezt.nix {};
        octez-bls12-381-hash = oself.callPackage ./octez/octez-bls12-381-hash.nix {};
        octez-bls12-381-polynomial = oself.callPackage ./octez/octez-bls12-381-polynomial.nix {};
        octez-bls12-381-signature = oself.callPackage ./octez/octez-bls12-381-signature.nix {};
        octez-crawler = oself.callPackage ./octez/octez-crawler.nix {};
        octez-distributed-internal = oself.callPackage ./octez/octez-distributed-internal.nix {};
        octez-distributed-lwt-internal = oself.callPackage ./octez/octez-distributed-lwt-internal.nix {};
        octez-injector = oself.callPackage ./octez/octez-injector.nix {};
        octez-mec = oself.callPackage ./octez/octez-mec.nix {};
        octez-plompiler = oself.callPackage ./octez/octez-plompiler.nix {};
        octez-plonk = oself.callPackage ./octez/octez-plonk.nix {};
        octez-polynomial = oself.callPackage ./octez/octez-polynomial.nix {};
        octez-smart-rollup-wasm-benchmark-lib = oself.callPackage ./octez/octez-smart-rollup-wasm-benchmark-lib.nix {};
      }))
    prev.ocaml-ng;
}
