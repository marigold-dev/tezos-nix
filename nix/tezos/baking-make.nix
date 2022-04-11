{ lib, buildDunePackage, ocamlPackages, tezos-stdlib
      , cacert, protocol-name }:

let
  underscore_name = builtins.replaceStrings [ "-" ] [ "_" ] protocol-name;
  src = "${tezos-stdlib.base_src}/src";
in rec {
  baking = buildDunePackage {
    pname = "tezos-baking-${protocol-name}";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    buildInputs = with ocamlPackages; [
      tezos-base
      tezos-version
      tezos-alpha.protocol
      tezos-alpha.protocol-plugin
      tezos-alpha.protocol-parameters
      tezos-protocol-environment
      tezos-shell-services
      tezos-client-base
      tezos-client-alpha
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

  commands = buildDunePackage {
    pname = "tezos-baking-${protocol-name}-commands";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    buildInputs = with ocamlPackages; [
      baking
      tezos-rpc
      tezos-base
      tezos-alpha.protocol
      tezos-stdlib-unix
      tezos-protocol-environment
      tezos-shell-services
      tezos-shell-context
      tezos-client-base
      tezos-client-alpha
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
}