{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-mockup-proxy,
  tezos-context,
  ringo-lwt,
  alcotest-lwt,
  qcheck-alcotest,
  tezos-base-test-helpers,
  tezos-shell-services-test-helpers,
}:
buildDunePackage {
  pname = "tezos-proxy";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [ringo-lwt tezos-mockup-proxy tezos-context];

  checkInputs = [
    alcotest-lwt
    qcheck-alcotest
    tezos-base-test-helpers
    tezos-shell-services-test-helpers
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}
