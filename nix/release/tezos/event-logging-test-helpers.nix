{ lib
, buildDunePackage
, alcotest
, tezos-event-logging
, tezos-stdlib
, tezos-test-helpers
}:

buildDunePackage {
  pname = "tezos-event-logging-test-helpers";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ alcotest tezos-event-logging tezos-test-helpers ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description = "Tezos: test helpers for the event logging library";
  };
}
