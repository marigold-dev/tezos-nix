{ lib
, buildDunePackage
, octez-libs
, qcheck-core
, qcheck-alcotest
,
}:
buildDunePackage {
  pname = "tezos-shell-services-test-helpers";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ tezos-shell-services tezos-test-helpers qcheck-core ];

  checkInputs = [ qcheck-alcotest ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: shell_services test helpers";
    };
}
