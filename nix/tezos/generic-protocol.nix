{ lib, buildDunePackage, ocamlPackages, tezos-stdlib, cacert, protocol-name }:

let
  underscore_name = builtins.replaceStrings [ "-" ] [ "_" ] protocol-name;
  src = "${tezos-stdlib.base_src}";
in
rec {
  client = buildDunePackage {
    pname = "tezos-client-${protocol-name}";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [
      protocol-parameters
      protocol-plugin
      protocol

      tezos-mockup-registration
      tezos-proxy
      tezos-signer-backends
    ];

    checkInputs = with ocamlPackages; [
      alcotest-lwt
      tezos-base-test-helpers
      ppx_inline_test
    ];

    # flaky
    doCheck = false;
  };

  client-commands = buildDunePackage {
    pname = "tezos-client-${protocol-name}-commands";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit src;

    buildInputs = with ocamlPackages; [ client tezos-client-base-unix ];

    doCheck = true;
  };

  client-commands-registration = buildDunePackage {
    pname = "tezos-client-${protocol-name}-commands-registration";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [ sapling-client ];

    doCheck = true;
  };

  sapling-client = buildDunePackage {
    pname = "tezos-client-sapling-${protocol-name}";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [ tezos-client-base-unix tezos-client-commands client client-commands protocol ];

    doCheck = true;
  };

  baking = buildDunePackage {
    pname = "tezos-baking-${protocol-name}";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit src;

    buildInputs = with ocamlPackages; [
      protocol
      protocol-plugin
      protocol-parameters
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
      tezos-rpc-http-client-unix
      tezos-rpc
      tezos-rpc-http
      lwt-canceler
      lwt-exit
      tezos-tooling
      data-encoding
      tezos-client-base-unix
      tezos-mockup
      tezos-mockup-proxy
      tezos-mockup-commands
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
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit src;

    postPatch = ''
      touch tezos-injector-alpha.opam
    '';

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol
      tezos-base
      tezos-client-base
      tezos-crypto
      tezos-micheline
      tezos-shell
      tezos-workers
    ];
  };

  baking-commands = buildDunePackage {
    pname = "tezos-baking-${protocol-name}-commands";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [
      baking
      protocol
      client

      tezos-rpc
      tezos-base
      tezos-stdlib-unix
      tezos-protocol-environment
      tezos-shell-services
      tezos-shell-context
      tezos-client-base
      tezos-client-commands
      lwt-exit
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
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit src;

    postPatch = ''
      substituteInPlace ./proto_${underscore_name}/lib_protocol/dune.inc \
        --replace "-warn-error +a" "-warn-error -A" \
        --replace "-warn-error \"+a\"" "-warn-error -A" || true
    '';

    strictDeps = true;

    nativeBuildInputs = with ocamlPackages; [ tezos-protocol-compiler ];

    buildInputs =
      with ocamlPackages; [ tezos-protocol-environment ];

    doCheck = true;

    meta = tezos-stdlib.meta // {
      description = "Tezos/Protocol: economic-protocol definition";
    };
  };

  protocol-parameters = buildDunePackage {
    pname = "tezos-protocol-${protocol-name}-parameters";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit (protocol) postPatch;
    inherit src;

    strictDeps = true;

    buildInputs = with ocamlPackages; [ protocol tezos-protocol-environment ];

    doCheck = true;

    meta = tezos-stdlib.meta // { description = "Tezos/Protocol: parameters"; };
  };

  embedded-protocol = buildDunePackage {
    pname = "tezos-embedded-protocol-${protocol-name}";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit (protocol) postPatch;
    inherit src;

    strictDeps = true;

    nativeBuildInputs = with ocamlPackages; [ tezos-protocol-compiler ];

    buildInputs = with ocamlPackages; [ tezos-protocol-updater ];

    propagatedBuildInputs = [ protocol ];

    doCheck = true;

    meta = tezos-stdlib.meta // {
      description =
        "Tezos/Protocol: economic-protocol definition, embedded in `tezos-node`";
    };
  };

  protocol-plugin = buildDunePackage {
    pname = "tezos-protocol-plugin-${protocol-name}";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit (protocol) postPatch;
    inherit src;

    strictDeps = true;

    buildInputs = with ocamlPackages; [
      embedded-protocol
      protocol-parameters
      protocol

      tezos-shell
      qcheck-alcotest
      tezos-test-helpers
    ];

    checkInputs = with ocamlPackages; [ qcheck-alcotest tezos-test-helpers ];

    doCheck = true;

    meta = tezos-stdlib.meta // {
      description = "Tezos/Protocol: protocol plugin registerer";
    };
  };

  protocol-plugin-registerer = buildDunePackage {
    pname = "tezos-protocol-plugin-${protocol-name}-registerer";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    inherit (protocol) postPatch;
    inherit src;

    strictDeps = true;

    buildInputs = with ocamlPackages; [ protocol embedded-protocol tezos-shell ];

    propagatedBuildInputs = with ocamlPackages; [ protocol-plugin ];

    doCheck = true;

    meta = tezos-stdlib.meta // {
      description = "Tezos/Protocol: protocol plugin registerer";
    };
  };

  test-helpers = buildDunePackage {
    pname = "tezos-${protocol-name}-test-helpers";
    inherit (tezos-stdlib) version;
    duneVersion = "3";
    src = "${tezos-stdlib.base_src}";

    propagatedBuildInputs = with ocamlPackages; [
      client
      protocol
      protocol-parameters

      tezos-base
      tezos-protocol-environment
      tezos-shell-services
      tezos-stdlib-unix
      tezos-test-helpers
    ];

    doCheck = true;

    meta = tezos-stdlib.meta // {
      description = "Tezos/Protocol: protocol testing framework";
    };
  };
}
