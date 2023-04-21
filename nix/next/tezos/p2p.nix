{
  lib,
  buildDunePackage,
  alcotest-lwt,
  astring,
  lwt,
  lwt-canceler,
  lwt-watcher,
  ringo,
  tezos-base-test-helpers,
  tezos-p2p-services,
  tezos-stdlib,
  tezos-version,
  prometheus,
}:
buildDunePackage {
  pname = "tezos-p2p";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    lwt
    lwt-canceler
    lwt-watcher
    ringo
    tezos-p2p-services
    prometheus
    tezos-version
  ];

  checkInputs = [alcotest-lwt astring tezos-base-test-helpers];

  doCheck = false; # some tests fail

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library for a pool of P2P connections";
    };
}
