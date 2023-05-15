{
  pkgs,
  stdenv,
  lib,
  fetchFromGitLab,
  ocamlPackages,
  zcash,
  cacert,
  static ? false,
  doCheck,
}: let
  ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_14;
in
  with ocamlPackages;
    {
      trunk-octez-client = buildDunePackage rec {
        pname = "octez-client";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        buildInputs = with ocamlPackages; [
          tezos-signer-backends
          tezos-client-base-unix

          tezos-alpha.protocol-plugin
          tezos-alpha.baking-commands
          tezos-016-PtMumbai.baking-commands
          tezos-016-PtMumbai.protocol-plugin
          tezos-017-PtNairob.baking-commands
          tezos-017-PtNairob.protocol
          tezos-017-PtNairob.protocol-plugin
        ];

        inherit doCheck;

        meta = {
          description = "octez-client binary";
          mainProgram = pname;
        };
      };

      trunk-octez-codec =
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

            tezos-016-PtMumbai.protocol-plugin
            tezos-016-PtMumbai.baking-commands
            tezos-017-PtNairob.protocol-plugin
            tezos-017-PtNairob.baking-commands
          ];

          inherit doCheck;

          isLibrary = false;

          meta = {
            description = "`octez-codec` binary to encode and decode values";
            mainProgram = pname;
          };
        };

      trunk-octez-dac-node = ocamlPackages.buildDunePackage rec {
        pname = "octez-dac-node";
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
          tezos-dac-node-lib
          tezos-layer2-store
          irmin-pack
          irmin
          tezos-017-PtNairob.dac
        ];

        checkInputs = with ocamlPackages; [tezos-base-test-helpers];

        doCheck = true;

        meta = {
          description = "`octez-dac-node` binary";
          mainProgram = pname;
        };
      };

      trunk-octez-dal-node = ocamlPackages.buildDunePackage rec {
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
          tezos-store
          tezos-dal-node-lib
          tezos-dal-node-services
          tezos-layer2-store
          tezos-crypto-dal
          irmin-pack
          irmin
          tezos-016-PtMumbai.dal
          tezos-017-PtNairob.dal
        ];

        checkInputs = with ocamlPackages; [tezos-base-test-helpers];

        doCheck = true;

        meta = {
          description = "`octez-dal-node` binary";
          mainProgram = pname;
        };
      };

      trunk-octez-evm-proxy = ocamlPackages.buildDunePackage rec {
        pname = "octez-evm-proxy";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        buildInputs = with ocamlPackages; [
          tezos-base
          tezos-clic
          tezos-rpc
          tezos-rpc-http
          tezos-rpc-http-server
          tezos-rpc-http-client-unix
          tezos-stdlib-unix
          tezos-crypto
          tezos-stdlib
          tezos-version
          lwt-exit
        ];

        checkInputs = with ocamlPackages; [tezos-base-test-helpers];

        doCheck = true;

        meta = {
          description = "`octez-dal-node` binary";
          mainProgram = "${pname}-server";
        };
      };

      trunk-octez-node = ocamlPackages.buildDunePackage rec {
        pname = "octez-node";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        buildInputs = with ocamlPackages; [
          tls
          tezos-base
          tezos-version
          tezos-rpc-http-server
          tezos-p2p
          tezos-shell
          tezos-workers
          tezos-protocol-updater
          tezos-validation
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
          tezos-016-PtMumbai.embedded-protocol
          tezos-016-PtMumbai.protocol-plugin-registerer
          tezos-017-PtNairob.embedded-protocol
          tezos-017-PtNairob.protocol-plugin-registerer
          tezos-alpha.protocol-plugin-registerer
          tezos-016-PtMumbai.protocol-plugin
          tezos-017-PtNairob.protocol-plugin
          prometheus-app
          lwt-exit
          tls
          tls-lwt
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

      trunk-octez-proxy-server = ocamlPackages.buildDunePackage rec {
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

      trunk-octez-signer = ocamlPackages.buildDunePackage rec {
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

      trunk-octez-snoop = ocamlPackages.buildDunePackage rec {
        pname = "octez-snoop";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        nativeBuildInputs = with ocamlPackages; [ocp-ocamlres pkgs.jq];

        propagatedBuildInputs = [ocamlPackages.findlib];

        buildInputs = with ocamlPackages; [
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

      trunk-octez-testnet-scenarios = ocamlPackages.buildDunePackage rec {
        pname = "octez-testnet-scenarios";
        inherit (ocamlPackages.tezos-stdlib) version src;

        minimalOCamlVersion = "4.14";

        duneVersion = "3";

        buildInputs = with ocamlPackages; [
          tezt
          tezt-tezos
          tezt-ethereum
        ];

        doCheck = true;

        meta = {
          description = "Run scenarios on testnets";
          mainProgram = pname;
        };
      };

      trunk-tezos-tps-evaluation = ocamlPackages.buildDunePackage rec {
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

      trunk-octez-smart-rollup-wasm-debugger = ocamlPackages.buildDunePackage rec {
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
          octez-smart-rollup-wasm-benchmark-lib
        ];

        doCheck = true;

        meta = {
          description = "Debugger for the smart rollups’ WASM kernels";
          mainProgram = "tezos-node";
        };
      };
    }
    // (ocamlPackages.callPackage ./generic-protocol-bin.nix {
      inherit doCheck;
      protocol-name = "alpha";
      protocol-libs = tezos-alpha;
    })
    // (ocamlPackages.callPackage ./generic-protocol-bin.nix {
      inherit doCheck;
      protocol-name = "PtNairob";
      protocol-libs = tezos-017-PtNairob;
    })
