{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-stdlib-unix,
  tezos-base,
  tezos-crypto,
  tezos-shell-services,
  aches,
  aches-lwt,
  tezos-validation,
  tezos-version,
  index,
  irmin-pack,
  tezos-protocol-environment,
  tezos-context,
  tezos-context-ops,
  tezos-shell-context,
  tezos-protocol-updater,
  lwt-watcher,
  camlzip,
  tar,
  tar-unix,
  prometheus,
  tezos-rpc,
  tezos-alpha,
  tezos-genesis,
  tezos-demo-noops,
  alcotest-lwt,
  tezos-test-helpers,
  digestif
}:
buildDunePackage {
  pname = "tezos-store";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-stdlib-unix
    tezos-base
    tezos-crypto
    tezos-shell-services
    aches
    aches-lwt
    tezos-validation
    tezos-version
    index
    irmin-pack
    tezos-protocol-environment
    tezos-context
    tezos-context-ops
    tezos-shell-context
    tezos-protocol-updater
    tezos-stdlib
    lwt-watcher
    camlzip
    tar
    tar-unix
    prometheus
    tezos-rpc
    digestif
  ];

  # nativeBuildInputs = [octez-protocol-compiler];

  strictDeps = true;

  checkInputs = [
    tezos-demo-noops.embedded-protocol
    tezos-genesis.embedded-protocol
    tezos-alpha.embedded-protocol
    tezos-alpha.protocol
    tezos-alpha.protocol-plugin
    alcotest-lwt
    tezos-test-helpers
  ];

  # We're getting infinite recursion from the function that creates the protocol packages
  # If we want to enable this we need to split that function again, but it seems worth it to skip this test
  doCheck = false;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: custom economic-protocols environment implementation for `octez-client` and testing";
    };
}
