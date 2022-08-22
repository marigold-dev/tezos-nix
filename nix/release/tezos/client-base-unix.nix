{ lib
, buildDunePackage
, tezos-stdlib
, tezos-client-base
, lwt-exit
, tezos-signer-backends
, tezos-proxy
, tezos-mockup-commands
, alcotest-lwt
, tezos-base-test-helpers
, cacert
}:

buildDunePackage {
  pname = "tezos-client-base-unix";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    tezos-client-base
    lwt-exit
    tezos-signer-backends
    tezos-proxy
    tezos-mockup-commands
  ];

  checkInputs = [ alcotest-lwt tezos-base-test-helpers cacert ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description = "Tezos: protocol registration for the mockup mode";
  };
}
