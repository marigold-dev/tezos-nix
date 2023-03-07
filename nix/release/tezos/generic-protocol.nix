{
  lib,
  buildDunePackage,
  ocamlPackages,
  tezos-stdlib,
  cacert,
  protocol-name,
}: let
  underscore_name = builtins.replaceStrings ["-"] ["_"] protocol-name;
in rec {
  client = buildDunePackage {
    pname = "tezos-client-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      protocol-plugin
      protocol

      tezos-mockup-registration
      tezos-proxy
      tezos-signer-backends
      tezos-client-commands
      tezos-client-base-unix
    ];

    checkInputs = with ocamlPackages; [
      alcotest-lwt
      tezos-base-test-helpers
      ppx_inline_test
    ];

    # flaky
    doCheck = false;
  };

  sapling-client = buildDunePackage {
    pname = "tezos-client-sapling-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

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
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    buildInputs = with ocamlPackages; [
      protocol
      protocol-plugin
      client

      tezos-base
      tezos-version
      tezos-protocol-environment
      tezos-shell-services
      tezos-client-base
      tezos-client-commands
      tezos-stdlib
      tezos-stdlib-unix
      tezos-shell-context
      tezos-context
      tezos-context-ops
      tezos-rpc-http-client-unix
      tezos-rpc
      tezos-rpc-http
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
      tezos-base-test-helpers
      cacert
    ];

    # flaky
    doCheck = false;
  };

  injector = buildDunePackage {
    pname = "tezos-injector-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol

      ppx_expect
      tezos-base
      tezos-stdlib-unix
      tezos-crypto
      tezos-micheline
      tezos-client-base
      tezos-workers
      tezos-shell
      tezos-layer2-utils-alpha
    ];
  };

  baking-commands = buildDunePackage {
    pname = "tezos-baking-${protocol-name}-commands";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      baking
      protocol
      client

      tezos-rpc
      tezos-base
      tezos-context-ops
      tezos-stdlib-unix
      tezos-protocol-environment
      tezos-shell-services
      tezos-shell-context
      tezos-client-base
      tezos-client-commands
      lwt-exit
      tezos-dal-node-services
    ];

    checkInputs = [
      # alcotest-lwt
      # qcheck-alcotest
      # tezos-test-helpers
      # tezos-base-test-helpers
      # cacert
    ];

    doCheck = true;
  };

  protocol = buildDunePackage {
    pname = "tezos-protocol-${protocol-name}";
    inherit (tezos-stdlib) version src;
    duneVersion = "3";

    strictDeps = true;

    nativeBuildInputs = with ocamlPackages; [octez-protocol-compiler];

    buildInputs = with ocamlPackages; [tezos-protocol-environment];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: economic-protocol definition";
      };
  };

  embedded-protocol = buildDunePackage {
    pname = "tezos-embedded-protocol-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    strictDeps = true;

    nativeBuildInputs = with ocamlPackages; [octez-protocol-compiler];

    buildInputs = with ocamlPackages; [tezos-protocol-updater octez-protocol-compiler];

    propagatedBuildInputs = [protocol];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: economic-protocol definition, embedded in `tezos-node`";
      };
  };

  protocol-plugin = buildDunePackage {
    pname = "tezos-protocol-plugin-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    strictDeps = true;

    buildInputs = with ocamlPackages; [
      embedded-protocol
      protocol

      tezos-shell
      qcheck-alcotest
      tezos-test-helpers
    ];

    checkInputs = with ocamlPackages; [qcheck-alcotest tezos-test-helpers];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: protocol plugin registerer";
      };
  };

  protocol-plugin-registerer = buildDunePackage {
    pname = "tezos-protocol-plugin-${protocol-name}-registerer";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    strictDeps = true;

    buildInputs = with ocamlPackages; [protocol embedded-protocol tezos-shell];

    propagatedBuildInputs = with ocamlPackages; [protocol-plugin];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: protocol plugin registerer";
      };
  };

  test-helpers = buildDunePackage {
    pname = "tezos-${protocol-name}-test-helpers";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol

      tezos-base
      tezos-protocol-environment
      tezos-shell-services
      tezos-stdlib-unix
      tezos-test-helpers
    ];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: protocol testing framework";
      };
  };

  layer2-utils = buildDunePackage {
    pname = "tezos-layer2-utils-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol

      ppx_expect
      tezos-base
      tezos-rpc
    ];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: protocol specific library for Layer 2 utils";
      };
  };

  smart-rollup = buildDunePackage {
    pname = "tezos-smart-rollup-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      protocol
      injector

      ppx_expect
      tezos-protocol-environment
      tezos-base
    ];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: protocol specific library of helpers for `tezos-smart-rollup`";
      };
  };

  benchmark-type-inference = buildDunePackage {
    pname = "tezos-benchmark-type-inference-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      protocol
      client

      tezos-stdlib
      tezos-error-monad
      tezos-crypto
      tezos-micheline
      tezos-micheline-rewriting
      tezos-protocol-environment
      hashcons
    ];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: library for writing benchmarks (protocol-specific part)";
      };
  };

  benchmark = buildDunePackage {
    pname = "tezos-benchmark-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      benchmark-type-inference
      protocol
      test-helpers

      tezos-stdlib
      tezos-base
      tezos-error-monad
      tezos-micheline
      tezos-micheline-rewriting
      tezos-benchmark
      tezos-crypto

      hashcons
      prbnmcn-stats
    ];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: library for writing benchmarks (protocol-specific part)";
      };
  };

  benchmarks = buildDunePackage {
    pname = "tezos-benchmarks-proto-${protocol-name}";
    inherit (tezos-stdlib) version src postPatch;
    duneVersion = "3";

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol
      protocol-plugin
      benchmark
      benchmark-type-inference
      test-helpers

      tezos-stdlib
      tezos-base
      tezos-error-monad
      tezos-lazy-containers
      tezos-benchmark
      tezos-crypto
      tezos-shell-benchmarks
      tezos-micheline
      tezos-sapling
      tezos-protocol-environment
    ];

    doCheck = true;

    meta =
      tezos-stdlib.meta
      // {
        description = "Tezos/Protocol: protocol benchmarks";
      };
  };
}
