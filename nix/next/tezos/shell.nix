{
  lib,
  buildDunePackage,
  octez-libs,
  ppx_expect,
  lwt-watcher,
  lwt-canceler,
  prometheus,
  tezos-store,
  tezos-context-ops,
  tezos-protocol-updater,
  tezos-validation,
  tezos-version,
  lwt-exit,
  alcotest-lwt,
  tezos-demo-noops,
  tezos-alpha,
}:
buildDunePackage {
  pname = "tezos-shell";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    ppx_expect
    lwt-watcher
    lwt-canceler
    prometheus
    tezos-store
    tezos-context-ops
    tezos-protocol-updater
    tezos-validation
    tezos-version
    lwt-exit
  ];

  checkInputs = [
    alcotest-lwt
    tezos-demo-noops.embedded-protocol
    tezos-alpha.protocol-plugin
  ];

  # We're getting infinite recursion from the function that creates the protocol packages
  # If we want to enable this we need to split that function again, but it seems worth it to skip this test
  doCheck = false;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: descriptions of RPCs exported by `tezos-shell`";
    };
}
