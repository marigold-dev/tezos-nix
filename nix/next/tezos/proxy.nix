{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-mockup-proxy,
  tezos-context,
  alcotest-lwt,
  qcheck-alcotest,
  tezos-base-test-helpers,
}:
buildDunePackage {
  pname = "tezos-proxy";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-mockup-proxy tezos-context];

  checkInputs = [
    alcotest-lwt
    qcheck-alcotest
    tezos-base-test-helpers
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}
