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
  trunk-octez-client = buildDunePackage rec {
    pname = "octez-client";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      uri

      tezos-alpha.libs
      protocol-N-1.libs
      protocol-N.libs
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
        inherit (ocamlPackages.octez-libs) version src;

        minimalOCamlVersion = "4.14";


        buildInputs = with ocamlPackages; [
          data-encoding
          octez-libs
          octez-shell-libs
          tezos-version

          protocol-N-1.libs
          protocol-N.libs
          tezos-alpha.libs
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
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      tezos-dac-lib
      tezos-dac-node-lib
      octez-l2-libs
      irmin-pack
      irmin
      protocol-N-1.libs
      protocol-N.libs
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-dac-node` binary";
      mainProgram = pname;
    };
  };

  trunk-octez-dal-node = ocamlPackages.buildDunePackage rec {
    pname = "octez-dal-node";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      cmdliner
      octez-shell-libs
      tezos-dal-node-lib
      tezos-dal-node-services
      octez-l2-libs
      irmin-pack
      irmin
      prometheus-app
      protocol-N-1.libs
      protocol-N.libs
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-dal-node` binary";
      mainProgram = pname;
    };
  };

  trunk-octez-evm-proxy = ocamlPackages.buildDunePackage rec {
    pname = "octez-evm-proxy";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      tezos-version
      octez-evm-proxy-lib-dev
      octez-evm-proxy-lib-prod
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-dal-node` binary";
      mainProgram = "${pname}-server";
    };
  };

  trunk-octez-node = ocamlPackages.buildDunePackage rec {
    pname = "octez-node";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      tezos-version
      octez-node-config
      octez-shell-libs
      cmdliner
      fmt
      tls-lwt
      prometheus-app
      lwt-exit
      uri

      protocol-N-1.libs
      protocol-N.libs

      tezos-alpha.protocol
      tezos-000-Ps9mPmXa.protocol
      tezos-001-PtCJ7pwo.protocol
      tezos-002-PsYLVpVv.protocol
      tezos-003-PsddFKi3.protocol
      tezos-004-Pt24m4xi.protocol
      tezos-005-PsBABY5H.protocol
      tezos-005-PsBabyM1.protocol
      tezos-006-PsCARTHA.protocol
      tezos-007-PsDELPH1.protocol
      tezos-008-PtEdo2Zk.protocol
      tezos-009-PsFLoren.protocol
      tezos-010-PtGRANAD.protocol
      tezos-011-PtHangz2.protocol
      tezos-012-Psithaca.protocol
      tezos-013-PtJakart.protocol
      tezos-014-PtKathma.protocol
      tezos-015-PtLimaPt.protocol
      tezos-016-PtMumbai.protocol
      tezos-017-PtNairob.protocol
      tezos-018-Proxford.protocol
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

  trunk-octez-proxy-server = ocamlPackages.buildDunePackage rec {
    pname = "octez-proxy-server";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      cmdliner
      lwt-exit
      lwt
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

  trunk-octez-signer = ocamlPackages.buildDunePackage rec {
    pname = "octez-signer";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
    ];

    checkInputs = with ocamlPackages; [ ];

    doCheck = true;

    meta = {
      description = "`octez-signer` binary";
      mainProgram = pname;
    };
  };

  trunk-octez-snoop = ocamlPackages.buildDunePackage rec {
    pname = "octez-snoop";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    nativeBuildInputs = with ocamlPackages; [ ocp-ocamlres pkgs.jq ];

    propagatedBuildInputs = [ ocamlPackages.findlib ];

    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      tezos-benchmark
      tezos-benchmark-examples
      tezos-alpha.benchmarks
      ocamlgraph
      pyml
      prbnmcn-stats
      tezos-version
    ];

    doCheck = true;

    meta = {
      description = "`octez-snoop` binary";
      mainProgram = pname;
    };
  };

  trunk-octez-testnet-scenarios = ocamlPackages.buildDunePackage rec {
    pname = "octez-testnet-scenarios";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


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
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    nativeBuildInputs = with ocamlPackages; [ ocp-ocamlres ];

    propagatedBuildInputs = [ ocamlPackages.findlib ];

    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      caqti
      caqti-dynload
      caqti-lwt
      data-encoding
      lwt
      tezos-alpha.libs
      tezos-alpha.protocol
      tezt
      tezt-tezos
      uri
    ];

    doCheck = true;

    meta = {
      description = "Tezos TPS evaluation tool";
      mainProgram = pname;
    };
  };

  trunk-octez-smart-rollup-wasm-debugger = ocamlPackages.buildDunePackage rec {
    pname = "octez-smart-rollup-wasm-debugger";
    inherit (ocamlPackages.octez-libs) version src;

    minimalOCamlVersion = "4.14";


    nativeBuildInputs = with ocamlPackages; [ ocp-ocamlres pkgs.jq ];

    buildInputs = with ocamlPackages; [
      octez-libs
      yaml
      tezos-alpha.libs
      octez-l2-libs
      tezos-version
    ];

    doCheck = true;

    meta = {
      description = "Debugger for the smart rollups’ WASM kernels";
      mainProgram = "octez-smart-rollup-wasm-debugger";
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
