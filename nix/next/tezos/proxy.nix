{ lib
, buildDunePackage
, octez-libs
, tezos-mockup-proxy
, alcotest-lwt
, qcheck-alcotest
,
}:
buildDunePackage {
  pname = "tezos-proxy";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ tezos-mockup-proxy octez-libs ];

  checkInputs = [
    alcotest-lwt
    qcheck-alcotest
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}
