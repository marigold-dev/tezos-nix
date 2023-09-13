{ lib
, buildDunePackage
, cacert
, ocamlPackages
, octez-libs
, protocol-name
, protocol-libs
, doCheck
,
}:
rec {
  "next-octez-accuser-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-accuser-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages; [
      protocol-libs.protocol
      protocol-libs.baking-commands
      protocol-libs.client

      tezos-client-commands
      tezos-client-base-unix
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} accuser binary";
      mainProgram = pname;
    };
  };

  "next-octez-baker-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-baker-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages; [
      protocol-libs.protocol
      protocol-libs.baking-commands
      protocol-libs.baking
      protocol-libs.client

      tezos-client-base
      tezos-client-base-unix
      tezos-mockup-commands
    ];

    checkInputs = with ocamlPackages; [
      alcotest-lwt
      cacert
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} baker binary";
      mainProgram = pname;
    };
  };

  "next-octez-smart-rollup-client-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-smart-rollup-client-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages; [
      protocol-libs.client
      protocol-libs.protocol
      protocol-libs.smart-rollup
      protocol-libs.smart-rollup-layer2

      tezos-client-base
      tezos-client-commands
      tezos-client-base-unix
      uri
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} Smart Rollup client binary";
      mainProgram = pname;
    };
  };

  "next-octez-smart-rollup-node-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-smart-rollup-node-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages; [
      octez-libs
      tezos-client-base
      tezos-client-base-unix

      protocol-libs.client
      protocol-libs.protocol
      protocol-libs.protocol-plugin

      tezos-dal-node-services
      tezos-dal-node-lib

      protocol-libs.dac
      tezos-dac-lib
      tezos-dac-client-lib
      octez-smart-rollup

      protocol-libs.smart-rollup
      protocol-libs.smart-rollup-layer2
      protocol-libs.layer2-utils
      tezos-layer2-store
      octez-crawler
      data-encoding
      irmin-pack
      irmin
      aches
      aches-lwt
      octez-injector
      octez-smart-rollup-node-lib
      tezos-scoru-wasm-fast
      tezos-version
      tezos-client-commands
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} Smart Rollup node binary";
      mainProgram = pname;
    };
  };
}
