{
  lib,
  buildDunePackage,
  cacert,
  ocamlPackages,
  tezos-stdlib,
  protocol-name,
  protocol-libs,
  doCheck,
}: let
  underscore_name = builtins.replaceStrings ["-"] ["_"] protocol-name;
  protocol_number = proto:
    if builtins.substring 0 4 proto == "demo"
    then -1
    else if proto == "alpha"
    then 1000
    else lib.toIntBase10 (builtins.substring 0 3 proto);
in rec {
  "trunk-octez-accuser-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-accuser-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    buildInputs = with ocamlPackages; [
      protocol-libs.protocol
      protocol-libs.baking-commands
      protocol-libs.client

      tezos-base
      tezos-clic
      tezos-client-commands
      tezos-stdlib-unix
      tezos-client-base-unix
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} accuser binary";
      mainProgram = pname;
    };
  };

  "trunk-octez-baker-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-baker-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    buildInputs = with ocamlPackages; [
      protocol-libs.protocol
      protocol-libs.baking-commands
      protocol-libs.baking
      protocol-libs.client

      tezos-base
      tezos-stdlib-unix
      tezos-protocol-environment
      tezos-shell-services
      tezos-shell-context
      tezos-client-base
      tezos-client-base-unix
      tezos-mockup-commands
      tezos-rpc
    ];

    checkInputs = with ocamlPackages; [
      alcotest-lwt
      tezos-base-test-helpers
      cacert
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} baker binary";
      mainProgram = pname;
    };
  };

  "trunk-octez-smart-rollup-client-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-smart-rollup-client-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    buildInputs = with ocamlPackages; [
      protocol-libs.client
      protocol-libs.protocol
      protocol-libs.smart-rollup
      protocol-libs.smart-rollup-layer2

      tezos-base
      tezos-clic
      tezos-client-base
      tezos-client-commands
      tezos-stdlib-unix
      tezos-client-base-unix
      tezos-rpc-http
      tezos-rpc-http-client-unix
      uri
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} Smart Rollup client binary";
      mainProgram = pname;
    };
  };

  "trunk-octez-smart-rollup-node-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-smart-rollup-node-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    buildInputs = with ocamlPackages;
      (
        if (builtins.trace protocol-name protocol-name) == "PtMumbai"
        then []
        else [protocol-libs.dac]
      )
      ++ [
        protocol-libs.protocol
        protocol-libs.protocol-plugin
        protocol-libs.client
        protocol-libs.smart-rollup
        protocol-libs.smart-rollup-layer2
        protocol-libs.layer2-utils

        tezos-base
        tezos-clic
        tezos-client-commands
        tezos-stdlib-unix
        tezos-client-base
        tezos-client-base-unix
        tezos-context
        tezos-rpc
        tezos-rpc-http
        tezos-rpc-http-server
        tezos-workers
        tezos-dal-node-services
        tezos-dal-node-lib
        tezos-shell-services
        tezos-layer2-store
        tezos-tree-encoding
        data-encoding
        irmin-pack
        irmin
        aches
        aches-lwt
        tezos-scoru-wasm
        tezos-scoru-wasm-fast
        tezos-crypto-dal
        prometheus-app
        octez-node-config
        octez-smart-rollup-node
      ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} Smart Rollup node binary";
      mainProgram = pname;
    };
  };
}
