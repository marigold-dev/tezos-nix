{ lib, buildDunePackage, ocamlPackages, tezos-stdlib, cacert, protocol-name }:

let
  underscore_name = builtins.replaceStrings [ "-" ] [ "_" ] protocol-name;
  src = "${tezos-stdlib.base_src}/src";
in rec {
  client = buildDunePackage {
    pname = "tezos-client-${protocol-name}";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [
      tezos-mockup-registration
      tezos-proxy
      tezos-signer-backends
      protocol-parameters
      protocol-plugin
      protocol
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
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [ client tezos-client-base-unix ];

    doCheck = true;
  };

  client-commands-registration = buildDunePackage {
    pname = "tezos-client-${protocol-name}-commands-registration";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    propagatedBuildInputs = [ sapling-client ];

    doCheck = true;
  };

  sapling-client = buildDunePackage {
    pname = "tezos-client-sapling-${protocol-name}";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [ tezos-client-base-unix tezos-client-commands client client-commands protocol ];

    doCheck = true;
  };

  baking = buildDunePackage {
    pname = "tezos-baking-${protocol-name}";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [
      tezos-shell-context
      tezos-client-commands
      client
      lwt-exit
      tezos-client-base-unix
    ];

    checkInputs = with ocamlPackages; [
      tezos-base-test-helpers
      protocol-parameters
      alcotest-lwt
      test-helpers
      cacert
    ];

    # flaky
    doCheck = false;
  };

  baking-commands = buildDunePackage {
    pname = "tezos-baking-${protocol-name}-commands";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [ baking ];

    doCheck = true;
  };

  # Only available for ithaca and newer
  baking-commands-registration = buildDunePackage {
    pname = "tezos-baking-${protocol-name}-commands-registration";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    buildInputs = with ocamlPackages; [ baking ];

    doCheck = true;
  };

  protocol = buildDunePackage {
    pname = "tezos-protocol-${protocol-name}";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    postPatch = ''
      substituteInPlace ./proto_${underscore_name}/lib_protocol/dune.inc \
        --replace "-warn-error +a" "-warn-error -A" \
        --replace "-warn-error \"+a\"" "-warn-error -A"
    '';

    strictDeps = true;

    nativeBuildInputs = with ocamlPackages; [ tezos-protocol-compiler ];

    buildInputs =
      with ocamlPackages; [ tezos-protocol-environment-sigs tezos-protocol-environment ];

    doCheck = true;

    meta = tezos-stdlib.meta // {
      description = "Tezos/Protocol: economic-protocol definition";
    };
  };

  protocol-parameters = buildDunePackage {
    pname = "tezos-protocol-${protocol-name}-parameters";
    inherit (tezos-stdlib) version useDune2;
    inherit (protocol) postPatch;
    inherit src;

    strictDeps = true;

    buildInputs = with ocamlPackages; [ protocol tezos-protocol-environment ];

    doCheck = true;

    meta = tezos-stdlib.meta // { description = "Tezos/Protocol: parameters"; };
  };

  embedded-protocol = buildDunePackage {
    pname = "tezos-embedded-protocol-${protocol-name}";
    inherit (tezos-stdlib) version useDune2;
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
    inherit (tezos-stdlib) version useDune2;
    inherit (protocol) postPatch;
    inherit src;

    strictDeps = true;

    buildInputs = with ocamlPackages; [
      embedded-protocol
      protocol
      tezos-shell
      protocol-parameters
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
    inherit (tezos-stdlib) version useDune2;
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
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [
      tezos-base
      client
      protocol
      protocol-parameters
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
