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

        tezos-store = osuper.tezos-store.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.digestif];
        });

        tezos-lwt-result-stdlib = osuper.tezos-lwt-result-stdlib.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.seqes];
        });

        tezos-proxy = oself.callPackage ./tezos/proxy.nix {};

        tezos-dac-lib = oself.callPackage ./tezos/dac-lib.nix {};
        tezos-dac-client-lib = oself.callPackage ./tezos/dac-client-lib.nix {};
        tezos-dac-node-lib = oself.callPackage ./tezos/dac-node-lib.nix {};

        tezos-crypto-dal = oself.callPackage ./tezos/crypto-dal.nix {};
        tezos-016-PtMumbai = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "016-PtMumbai";
          ocamlPackages = oself;
        };
        tezos-alpha = callPackage ./tezos/generic-protocol.nix {
          protocol-name = "alpha";
          ocamlPackages = oself;
        };
        octez-smart-rollup-wasm-benchmark-lib = oself.callPackage ./tezos/octez-smart-rollup-wasm-benchmark-lib.nix {};
        octez-crawler = oself.callPackage ./tezos/octez-crawler.nix {};
        octez-injector = oself.callPackage ./tezos/octez-injector.nix {};
      }))
    prev.ocaml-ng;
}
