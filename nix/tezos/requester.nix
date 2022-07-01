{ lib
, buildDunePackage
, tezos-stdlib
, tezos-base
, lwt-watcher
, alcotest-lwt
, qcheck-alcotest
, tezos-base-test-helpers
, tezos-test-helpers
}:

buildDunePackage {
  pname = "tezos-requester";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-base lwt-watcher ];

  checkInputs =
    [ alcotest-lwt qcheck-alcotest tezos-base-test-helpers tezos-test-helpers ];

  # Broken on aarch64-darwin
  doCheck = false;

  meta = tezos-stdlib.meta // {
    description = "Tezos: generic resource fetching service";
  };
}
