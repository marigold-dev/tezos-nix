{ lib
, buildDunePackage
, octez-libs
, aches
, aches-lwt
, tezos-validation
, tezos-version
, index
, irmin-pack
, tezos-context-ops
, tezos-protocol-updater
, lwt-watcher
, camlzip
, tar
, tar-unix
, prometheus
, tezos-alpha
, tezos-genesis
, tezos-demo-noops
, alcotest-lwt
, tezt
,
}:
buildDunePackage {
  pname = "tezos-store";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    aches
    aches-lwt
    tezos-validation
    index
    irmin-pack
    tezos-context-ops
    tezos-protocol-updater
    lwt-watcher
    camlzip
    tar
    tar-unix
    prometheus
  ];

  # nativeBuildInputs = [octez-protocol-compiler];

  strictDeps = true;

  checkInputs = [
    tezt
    tezos-demo-noops.embedded-protocol
    tezos-genesis.embedded-protocol
    tezos-alpha.embedded-protocol
    tezos-alpha.protocol
    tezos-alpha.protocol-plugin
    alcotest-lwt
  ];

  # We're getting infinite recursion from the function that creates the protocol packages
  # If we want to enable this we need to split that function again, but it seems worth it to skip this test
  doCheck = false;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: custom economic-protocols environment implementation for `octez-client` and testing";
    };
}
