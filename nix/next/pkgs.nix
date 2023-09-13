{ pkgs
, stdenv
, lib
, fetchFromGitLab
, ocamlPackages
, zcash
, cacert
, static ? false
, doCheck
,
}:
let
  ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_14;
  # Current protocol
  protocol-N = ocamlPackages.tezos-018-Proxford;
  # Last protocol
  protocol-N-1 = ocamlPackages.tezos-017-PtNairob;
in
with ocamlPackages;
{
  next-octez-client = buildDunePackage rec {
    pname = "octez-client";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs

      tezos-alpha.protocol
      tezos-alpha.protocol-plugin
      tezos-alpha.baking-commands
      tezos-017-PtNairob.baking-commands
      tezos-017-PtNairob.protocol
      tezos-017-PtNairob.protocol-plugin
      tezos-018-Proxford.protocol
      tezos-018-Proxford.protocol-plugin
      tezos-018-Proxford.baking-commands
    ];

    inherit doCheck;

    meta = {
      description = "octez-client binary";
      mainProgram = pname;
    };
  };

  next-octez-codec =
    ocamlPackages.buildDunePackage
      rec {
        pname = "octez-client";
        inherit (ocamlPackages.octez-libs) version src;

        minimalOCamlVersion = "4.14";


        buildInputs = with ocamlPackages; [
          data-encoding
          tezos-client-base-unix
          tezos-client-base
          tezos-signer-services

          protocol-N-1.protocol-plugin
          protocol-N-1.baking-commands
          protocol-N.protocol-plugin
          protocol-N.baking-commands
        ];

        inherit doCheck;

        isLibrary = false;

        meta = {
          description = "`octez-codec` binary to encode and decode values";
          mainProgram = pname;
        };
      };

  next-octez-dac-node = ocamlPackages.buildDunePackage rec {
    pname = "octez-dac-node";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      tezos-client-base
      tezos-client-base-unix
      tezos-client-commands
      tezos-protocol-updater
      octez-libs
      tezos-dac-node-lib
      tezos-layer2-store
      irmin-pack
      irmin
      tezos-017-PtNairob.dac
      protocol-N.dac
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-dac-node` binary";
      mainProgram = pname;
    };
  };

  next-octez-dal-node = ocamlPackages.buildDunePackage rec {
    pname = "octez-dal-node";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      cmdliner
      tezos-client-base
      tezos-client-base-unix
      tezos-client-commands
      tezos-protocol-updater
      tezos-dal-node-lib
      tezos-dal-node-services
      tezos-layer2-store
      tezos-store
      irmin-pack
      irmin
      prometheus-app
      protocol-N-1.dal
      protocol-N.dal
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-dal-node` binary";
      mainProgram = pname;
    };
  };

  next-octez-evm-proxy = ocamlPackages.buildDunePackage rec {
    pname = "octez-evm-proxy";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      octez-evm-proxy-lib
      tezos-version
      lwt-exit
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-dal-node` binary";
      mainProgram = "${pname}-server";
    };
  };

  next-octez-node = ocamlPackages.buildDunePackage rec {
    pname = "octez-node";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      tls
      tezos-version
      tezos-shell
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
      protocol-N-1.embedded-protocol
      protocol-N-1.protocol-plugin-registerer
      protocol-N-1.protocol-plugin
      protocol-N.embedded-protocol
      protocol-N.protocol-plugin-registerer
      protocol-N.protocol-plugin
      tezos-alpha.protocol-plugin-registerer
      prometheus-app
      lwt-exit
      tls
      tls-lwt
      cstruct
    ];

    checkInputs = with ocamlPackages; [ ];

    postInstall = ''
      patchShebangs tezos-sandboxed-node.sh
    '';

    doCheck = true;

    meta = {
      description = "`octez-node` binary";
      mainProgram = pname;
    };
  };

  next-octez-proxy-server = ocamlPackages.buildDunePackage rec {
    pname = "octez-proxy-server";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      cmdliner
      lwt-exit
      lwt
      tezos-proxy
      tezos-proxy-server-config
      tezos-version
      uri
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-proxy-server` binary";
      mainProgram = pname;
    };
  };

  next-octez-signer = ocamlPackages.buildDunePackage rec {
    pname = "octez-signer";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      tezos-client-base
      tezos-client-base-unix
      tezos-client-commands
      tezos-signer-services
      octez-libs
      tezos-signer-backends
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-signer` binary";
      mainProgram = pname;
    };
  };

  next-octez-snoop = ocamlPackages.buildDunePackage rec {
    pname = "octez-snoop";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    nativeBuildInputs = with ocamlPackages; [ ocp-ocamlres pkgs.jq ];

    propagatedBuildInputs = [ ocamlPackages.findlib ];

    buildInputs = with ocamlPackages; [
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

  next-octez-testnet-scenarios = ocamlPackages.buildDunePackage rec {
    pname = "octez-testnet-scenarios";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      tezt
    ];

    doCheck = true;

    meta = {
      description = "Run scenarios on testnets";
      mainProgram = pname;
    };
  };

  next-tezos-tps-evaluation = ocamlPackages.buildDunePackage rec {
    pname = "tezos-tps-evaluation";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    nativeBuildInputs = with ocamlPackages; [ ocp-ocamlres ];

    propagatedBuildInputs = [ ocamlPackages.findlib ];

    buildInputs = with ocamlPackages; [
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

  next-octez-smart-rollup-wasm-debugger = ocamlPackages.buildDunePackage rec {
    pname = "octez-smart-rollup-wasm-debugger";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    nativeBuildInputs = with ocamlPackages; [ ocp-ocamlres pkgs.jq ];

    buildInputs = with ocamlPackages; [
      octez-libs
      yaml
      tezos-version
      tezos-alpha.client
      tezos-scoru-wasm-helpers
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
  protocol-name = "Proxford";
  protocol-libs = protocol-N;
})
