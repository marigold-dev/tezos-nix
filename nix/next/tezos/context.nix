{ lib
, buildDunePackage
, octez-libs
, irmin
, irmin-pack
, bigstringaf
, digestif
, fmt
, tezt
, octez-alcotezt
, qcheck-alcotest
,
}:
buildDunePackage {
  pname = "tezos-context";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    irmin
    irmin-pack
    bigstringaf
    digestif
    fmt
  ];

  checkInputs = [ tezt octez-alcotezt qcheck-alcotest ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: library of auto-documented RPCs (service and hierarchy descriptions)";
    };
}
