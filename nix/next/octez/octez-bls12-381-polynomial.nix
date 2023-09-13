{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, ppx_repr
, bls12-381
, bigstringaf
, tezt
, octez-alcotezt
, qcheck-alcotest
, octez-polynomial
, bisect_ppx
,
}:
buildDunePackage {
  pname = "octez-bls12-381-polynomial";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    ppx_repr
    bls12-381
    bigstringaf
  ];

  checkInputs = [
    tezt
    octez-alcotezt
    qcheck-alcotest
    octez-polynomial
    bisect_ppx
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Implementation of BLS signatures for the pairing-friendly curve BLS12-381";
    };
}
