{
  lib,
  buildDunePackage,
  tezos-stdlib,
  ppx_expect,
  lwt-watcher,
  lwt-canceler,
  prometheus,
  tezos-base,
  tezos-rpc,
  tezos-context,
  tezos-store,
  tezos-protocol-environment,
  tezos-context-ops,
  tezos-shell-context,
  tezos-p2p,
  tezos-stdlib-unix,
  tezos-shell-services,
  tezos-p2p-services,
  tezos-protocol-updater,
  tezos-requester,
  tezos-workers,
  tezos-validation,
  tezos-version,
  lwt-exit,
  alcotest-lwt,
  tezos-base-test-helpers,
  tezos-test-helpers,
  tezos-demo-noops,
  tezos-alpha,
}:
buildDunePackage {
  pname = "tezos-shell";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ppx_expect
    lwt-watcher
    lwt-canceler
    prometheus
    tezos-base
    tezos-rpc
    tezos-context
    tezos-store
    tezos-protocol-environment
    tezos-context-ops
    tezos-shell-context
    tezos-p2p
    tezos-stdlib-unix
    tezos-shell-services
    tezos-p2p-services
    tezos-protocol-updater
    tezos-requester
    tezos-workers
    tezos-validation
    tezos-version
    lwt-exit
  ];

  checkInputs = [
    alcotest-lwt
    tezos-base-test-helpers
    tezos-test-helpers
    tezos-demo-noops.embedded-protocol
    tezos-alpha.protocol-plugin
  ];

  # We're getting infinite recursion from the function that creates the protocol packages
  # If we want to enable this we need to split that function again, but it seems worth it to skip this test
  doCheck = false;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: descriptions of RPCs exported by `tezos-shell`";
    };
}
