{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-mockup-registration,
  tezos-rpc-http-client,
  tezos-p2p,
  resto-cohttp-self-serving-client,
  tezos-mockup-proxy,
  alcotest-lwt,
  qcheck-alcotest,
  tezos-base-test-helpers,
}:
buildDunePackage {
  pname = "tezos-mockup";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-mockup-registration
    tezos-rpc-http-client
    tezos-p2p
    resto-cohttp-self-serving-client
    tezos-mockup-proxy
  ];

  checkInputs = [alcotest-lwt qcheck-alcotest tezos-base-test-helpers];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}
