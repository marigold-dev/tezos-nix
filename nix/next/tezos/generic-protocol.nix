{ lib
, buildDunePackage
, ocamlPackages
, octez-libs
, cacert
, protocol-name
,
}:
let
  underscore_name = builtins.replaceStrings [ "-" ] [ "_" ] protocol-name;
  protocol_number = proto:
    if builtins.substring 0 4 proto == "demo"
    then -1
    else if proto == "alpha"
    then 1000
    else lib.toIntBase10 (builtins.substring 0 3 proto);
in
rec {
  client = buildDunePackage {
    pname = "tezos-client-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      protocol-plugin
      protocol
      smart-rollup

      tezos-mockup-registration
      tezos-proxy
      tezos-signer-backends
      tezos-client-commands
      tezos-client-base-unix
    ];

    checkInputs = with ocamlPackages; [
      alcotest-lwt
      ppx_inline_test
    ];

    doCheck = true;
  };

  sapling-client = buildDunePackage {
    pname = "tezos-client-sapling-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      tezos-client-base-unix
      tezos-client-commands
      client
      protocol
    ];

    doCheck = true;
  };

  baking = buildDunePackage {
    pname = "tezos-baking-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages; [
      protocol
      protocol-plugin
      client

      tezos-version
      tezos-client-base
      tezos-client-commands
      octez-libs
      tezos-context-ops
      lwt-canceler
      lwt-exit
      data-encoding
      tezos-client-base-unix
      tezos-mockup
      tezos-mockup-proxy
      tezos-mockup-commands
      tezos-dal-node-services
    ];

    checkInputs = with ocamlPackages; [
      alcotest-lwt
      cacert
    ];

    doCheck = true;
  };

  dac = buildDunePackage {
    pname = "tezos-dac-${protocol-name}";
    inherit (octez-libs) version src;

    nativeBuildInputs = with ocamlPackages; [
      octez-protocol-compiler
    ];

    propagatedBuildInputs = with ocamlPackages; [
      client
      embedded-protocol
      protocol
      tezos-dac-client-lib
      tezos-dac-lib
    ];

    buildInputs = with ocamlPackages; [
      ppx_expect
    ];

    checkInputs = with ocamlPackages; [
      tezt
      test-helpers
      tezos-dac-node-lib
      octez-alcotezt
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol specific library for the Data availability Committee";
      };
  };

  dal = buildDunePackage {
    pname = "tezos-dal-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      protocol
      protocol-plugin
      embedded-protocol
      client
      layer2-utils

      octez-protocol-compiler
      tezos-dal-node-lib
    ];

    buildInputs = with ocamlPackages; [ ppx_expect ];

    checkInputs = with ocamlPackages; [
      test-helpers
      alcotest-lwt
      cacert
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol specific library for the Data availability Layer";
      };
  };

  injector = buildDunePackage {
    pname = "tezos-injector-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol
      tezos-client-base
      tezos-shell
      layer2-utils
    ];
  };

  baking-commands = buildDunePackage {
    pname = "tezos-baking-${protocol-name}-commands";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      baking
      protocol
      client

      tezos-context-ops
      tezos-client-base
      tezos-client-commands
      lwt-exit
      tezos-dal-node-services
    ];

    checkInputs = [
      # alcotest-lwt
      # qcheck-alcotest
      #       #       # cacert
    ];

    doCheck = true;
  };

  protocol = buildDunePackage {
    pname = "tezos-protocol-${protocol-name}";
    inherit (octez-libs) version src;

    nativeBuildInputs = [ ocamlPackages.octez-protocol-compiler ];
    propagatedBuildInputs = [ ocamlPackages.octez-libs ];

    doCheck = true;

    passthru.number = protocol_number protocol-name;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: economic-protocol definition";
      };
  };

  embedded-protocol = buildDunePackage {
    pname = "tezos-embedded-protocol-${protocol-name}";
    inherit (octez-libs) version src;

    strictDeps = true;

    nativeBuildInputs = with ocamlPackages; [ octez-protocol-compiler ];

    buildInputs = with ocamlPackages; [ tezos-protocol-updater octez-protocol-compiler ];

    propagatedBuildInputs = [ protocol ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: economic-protocol definition, embedded in `tezos-node`";
      };
  };

  protocol-plugin = buildDunePackage {
    pname = "tezos-protocol-plugin-${protocol-name}";
    inherit (octez-libs) version src;

    strictDeps = true;

    buildInputs = with ocamlPackages; [
      embedded-protocol
      protocol
      smart-rollup

      tezos-shell
      qcheck-alcotest
    ];

    checkInputs = with ocamlPackages; [ qcheck-alcotest ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol plugin registerer";
      };
  };

  protocol-plugin-registerer = buildDunePackage {
    pname = "tezos-protocol-plugin-${protocol-name}-registerer";
    inherit (octez-libs) version src;

    strictDeps = true;

    buildInputs = with ocamlPackages; [ protocol embedded-protocol tezos-shell ];

    propagatedBuildInputs = with ocamlPackages; [ protocol-plugin smart-rollup ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol plugin registerer";
      };
  };

  test-helpers = buildDunePackage {
    pname = "tezos-${protocol-name}-test-helpers";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol testing framework";
      };
  };

  layer2-utils = buildDunePackage {
    pname = "tezos-layer2-utils-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol

      ppx_expect
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol specific library for Layer 2 utils";
      };
  };

  smart-rollup = buildDunePackage {
    pname = "tezos-smart-rollup-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      protocol

      ppx_expect
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol specific library of helpers for `tezos-smart-rollup`";
      };
  };

  smart-rollup-node = buildDunePackage {
    pname = "octez-smart-rollup-node-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      octez-libs
      tezos-client-base
      tezos-client-base-unix

      client
      protocol
      protocol-plugin
      dac
      smart-rollup
      smart-rollup-layer2
      layer2-utils

      tezos-dal-node-services
      tezos-dal-node-lib
      tezos-dac-lib
      tezos-dac-client-lib
      octez-smart-rollup
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

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol specific library of helpers for `tezos-smart-rollup`";
      };
  };

  smart-rollup-layer2 = buildDunePackage {
    pname = "tezos-smart-rollup-layer2-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      octez-smart-rollup
      octez-injector
      protocol
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol specific library defining L2 operations";
      };
  };

  smart-rollup-client = buildDunePackage {
    pname = "octez-smart-rollup-client-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      smart-rollup
      smart-rollup-layer2
      protocol
      tezos-client-base
      tezos-client-base-unix
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol specific library of building clients for `tezos-smart-rollup`";
      };
  };

  benchmark-type-inference = buildDunePackage {
    pname = "tezos-benchmark-type-inference-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      protocol
      client

      octez-libs
      tezos-micheline-rewriting
      hashcons
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: library for writing benchmarks (protocol-specific part)";
      };
  };

  benchmark = buildDunePackage {
    pname = "tezos-benchmark-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      benchmark-type-inference
      protocol
      test-helpers

      octez-libs
      tezos-micheline-rewriting
      tezos-benchmark

      hashcons
      prbnmcn-stats
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: library for writing benchmarks (protocol-specific part)";
      };
  };

  benchmarks = buildDunePackage {
    pname = "tezos-benchmarks-proto-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol
      protocol-plugin
      benchmark
      benchmark-type-inference
      test-helpers

      octez-libs
      tezos-benchmark
      tezos-shell-benchmarks
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol benchmarks";
      };
  };
}
