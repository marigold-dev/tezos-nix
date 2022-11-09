{
  lib,
  buildDunePackage,
  alcotest,
  tezos-event-logging,
  tezos-stdlib,
  tezos-test-helpers,
}:
buildDunePackage {
  pname = "tezos-event-logging-test-helpers";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [alcotest tezos-event-logging tezos-test-helpers];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: test helpers for the event logging library";
    };
}
