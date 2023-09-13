{ lib
, buildDunePackage
, octez-libs
, tezos-mockup-registration
, resto-cohttp-self-serving-client
, tezos-mockup-proxy
, alcotest-lwt
, qcheck-alcotest
,
}:
buildDunePackage {
  pname = "tezos-mockup";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-mockup-registration
    resto-cohttp-self-serving-client
    tezos-mockup-proxy
  ];

  checkInputs = [ alcotest-lwt qcheck-alcotest ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}
