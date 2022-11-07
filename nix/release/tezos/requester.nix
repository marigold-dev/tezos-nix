{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  lwt-watcher,
  alcotest-lwt,
  qcheck-alcotest,
  tezos-base-test-helpers,
  tezos-test-helpers,
}:
buildDunePackage {
  pname = "tezos-requester";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-base lwt-watcher];

  checkInputs = [alcotest-lwt qcheck-alcotest tezos-base-test-helpers tezos-test-helpers];

  # Broken on aarch64-darwin
  doCheck = false;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: generic resource fetching service";
    };
}
