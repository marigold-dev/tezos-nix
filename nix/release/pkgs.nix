{
  pkgs,
  stdenv,
  lib,
  fetchFromGitLab,
  zcash,
  cacert,
  static ? false,
  doCheck,
}: let
  ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_14;
  inject-zcash = {
    nativeBuildInputs = [pkgs.makeWrapper];
    postFixup = ''
      for bin in $(find $out/bin -not -name '*.sh' -type f -executable); do
        wrapProgram "$bin" --prefix XDG_DATA_DIRS : ${pkgs.zcash-params}
      done
    '';
  };
in
  with ocamlPackages;
    rec {
      octez-client = buildDunePackage rec {
        pname = "octez-client";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        buildInputs = with ocamlPackages; [
          tezos-signer-backends
          tezos-client-base-unix

          tezos-alpha.protocol-plugin
          tezos-alpha.baking-commands

          tezos-015-PtLimaPt.protocol
          tezos-015-PtLimaPt.protocol-plugin
          tezos-015-PtLimaPt.baking-commands

          tezos-016-PtMumbai.protocol
          tezos-016-PtMumbai.protocol-plugin
          tezos-016-PtMumbai.baking-commands
        ];

        inherit doCheck;

        isLibrary = false;

        meta = {
          description = "octez-client binary";
          mainProgram = pname;
        };
      };

      octez-codec =
        ocamlPackages.buildDunePackage
        rec {
          pname = "octez-client";
          inherit (ocamlPackages.tezos-stdlib) version src;

          minimalOCamlVersion = "4.14";

          duneVersion = "3";

          buildInputs = with ocamlPackages; [
            data-encoding
            tezos-base
            tezos-client-base-unix
            tezos-client-base
            tezos-clic
            tezos-stdlib-unix
            tezos-event-logging
            tezos-signer-services

            tezos-015-PtLimaPt.protocol-plugin
            tezos-015-PtLimaPt.baking-commands
            tezos-016-PtMumbai.protocol-plugin
            tezos-016-PtMumbai.baking-commands
          ];

          inherit doCheck;

          isLibrary = false;

          meta = {
            description = "`octez-codec` binary to encode and decode values";
            mainProgram = pname;
          };
        };

      octez-dal-node = ocamlPackages.buildDunePackage rec {
        pname = "octez-dal-node";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        buildInputs = with ocamlPackages; [
          tezos-base
          tezos-clic
          tezos-client-base
          tezos-client-base-unix
          tezos-client-commands
          tezos-rpc-http
          tezos-rpc-http-server
          tezos-protocol-updater
          tezos-rpc-http-client-unix
          tezos-stdlib-unix
          tezos-stdlib
          tezos-dal-node-lib
          tezos-dal-node-services
          tezos-layer2-store
          tezos-crypto-dal
          irmin-pack
          irmin
          tezos-dal-016-PtMumbai
        ];

        checkInputs = with ocamlPackages; [tezos-base-test-helpers];

        doCheck = true;

        meta = {
          description = "`octez-dal-node` binary";
          mainProgram = pname;
        };
      };

      octez-node = ocamlPackages.buildDunePackage rec {
        pname = "octez-node";
        inherit (ocamlPackages.tezos-stdlib) version src;
        inherit (inject-zcash) nativeBuildInputs postFixup;

        duneVersion = "3";

        propagatedBuildInputs = [
          pkgs.zcash-params
        ];

        buildInputs = with ocamlPackages; [
          tls-lwt
          tezos-base
          tezos-version
          tezos-rpc-http-server
          tezos-p2p
          tezos-shell
          tezos-workers
          tezos-protocol-updater
          octez-node-config
          tezos-alpha.embedded-protocol
          tezos-000-Ps9mPmXa.embedded-protocol
          tezos-001-PtCJ7pwo.embedded-protocol
          tezos-002-PsYLVpVv.embedded-protocol
          tezos-003-PsddFKi3.embedded-protocol
          tezos-004-Pt24m4xi.embedded-protocol
          tezos-005-PsBABY5H.embedded-protocol
          tezos-005-PsBabyM1.embedded-protocol
          tezos-006-PsCARTHA.embedded-protocol
          tezos-007-PsDELPH1.embedded-protocol
          tezos-008-PtEdo2Zk.embedded-protocol
          tezos-009-PsFLoren.embedded-protocol
          tezos-010-PtGRANAD.embedded-protocol
          tezos-011-PtHangz2.embedded-protocol
          tezos-012-Psithaca.embedded-protocol
          tezos-013-PtJakart.embedded-protocol
          tezos-014-PtKathma.embedded-protocol
          tezos-015-PtLimaPt.embedded-protocol
          tezos-015-PtLimaPt.protocol-plugin-registerer
          tezos-016-PtMumbai.embedded-protocol
          tezos-016-PtMumbai.protocol-plugin-registerer
          tezos-alpha.protocol-plugin-registerer
          tezos-015-PtLimaPt.protocol-plugin
          tezos-016-PtMumbai.protocol-plugin
          prometheus-app
          lwt-exit
          tls
          cstruct
        ];

        checkInputs = with ocamlPackages; [tezos-base-test-helpers];

        postInstall = ''
          patchShebangs tezos-sandboxed-node.sh
        '';

        doCheck = true;

        meta = {
          description = "`octez-node` binary";
          mainProgram = pname;
        };
      };

      octez-proxy-server = ocamlPackages.buildDunePackage rec {
        pname = "octez-proxy-server";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        buildInputs = with ocamlPackages; [
          tezos-base
          tezos-stdlib-unix
          tezos-rpc
          cmdliner
          lwt-exit
          lwt
          tezos-proxy
          tezos-proxy-server-config
          tezos-rpc-http-client-unix
          tezos-rpc-http-server
          tezos-shell-services
          tezos-shell-context
          tezos-version
          uri
        ];

        checkInputs = with ocamlPackages; [tezos-base-test-helpers];

        doCheck = true;

        meta = {
          description = "`octez-proxy-server` binary";
          mainProgram = pname;
        };
      };

      octez-signer = ocamlPackages.buildDunePackage rec {
        pname = "octez-signer";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        buildInputs = with ocamlPackages; [
          tezos-base
          tezos-clic
          tezos-client-base
          tezos-client-base-unix
          tezos-client-commands
          tezos-signer-services
          tezos-rpc-http
          tezos-rpc-http-server
          tezos-rpc-http-client-unix
          tezos-stdlib-unix
          tezos-stdlib
          tezos-signer-backends
        ];

        checkInputs = with ocamlPackages; [tezos-base-test-helpers];

        doCheck = true;

        meta = {
          description = "`octez-signer` binary";
          mainProgram = pname;
        };
      };

      octez-snoop = ocamlPackages.buildDunePackage rec {
        pname = "octez-snoop";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        nativeBuildInputs = with ocamlPackages; [ocp-ocamlres pkgs.jq];

        propagatedBuildInputs = [ocamlPackages.findlib];

        buildInputs = with ocamlPackages; [
          tezos-base
          tezos-base
          tezos-stdlib-unix
          tezos-clic
          tezos-benchmark
          tezos-benchmark-examples
          tezos-alpha.benchmarks
          # tezos-shell-benchmarks
          # tezos-benchmarks-proto-alpha
          ocamlgraph
          pyml
          prbnmcn-stats
        ];

        doCheck = true;

        meta = {
          description = "`octez-snoop` binary";
          mainProgram = pname;
        };
      };

      tezos-tps-evaluation = ocamlPackages.buildDunePackage rec {
        pname = "tezos-tps-evaluation";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        nativeBuildInputs = with ocamlPackages; [ocp-ocamlres];

        propagatedBuildInputs = [ocamlPackages.findlib];

        buildInputs = with ocamlPackages; [
          tezos-base
          caqti
          caqti-dynload
          caqti-lwt
          data-encoding
          lwt
          tezos-client-base-unix
          tezos-alpha.baking
          tezos-alpha.client
          tezos-alpha.protocol
          tezt
          tezt-tezos
          tezt-performance-regression
          uri
          tezos-dal-node-services
          tezos-context-ops
        ];

        doCheck = true;

        meta = {
          description = "Tezos TPS evaluation tool";
          mainProgram = pname;
        };
      };

      octez-smart-rollup-wasm-debugger = ocamlPackages.buildDunePackage rec {
        pname = "octez-smart-rollup-wasm-debugger";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        nativeBuildInputs = with ocamlPackages; [ocp-ocamlres pkgs.jq];

        propagatedBuildInputs = [ocamlPackages.findlib];

        buildInputs = with ocamlPackages; [
          tezos-base
          tezos-clic
          tezos-tree-encoding

          tezos-alpha.client
          tezos-scoru-wasm
          tezos-scoru-wasm-helpers
          tezos-webassembly-interpreter
          tezos-webassembly-interpreter-extra
        ];

        doCheck = true;

        meta = {
          description = "Debugger for the smart rollups’ WASM kernels";
          mainProgram = pname;
        };
      };

      inherit
        (pkgs.callPackage ./scripts.nix {
          octez-node = octez-node;
        })
        tezos-node-configurator
        tezos-snapshot-downloader
        ;
    }
    // (ocamlPackages.callPackage ./generic-protocol-bin.nix {
      inherit doCheck inject-zcash;
      protocol-name = "alpha";
      protocol-libs = tezos-alpha;
    })
    // (ocamlPackages.callPackage ./generic-protocol-bin.nix {
      inherit doCheck inject-zcash;
      protocol-name = "PtMumbai";
      protocol-libs = tezos-016-PtMumbai;
    })
