{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, bls12-381
, eqaf
, bisect_ppx
, alcotest
, tezt
, octez-alcotezt
,
}:
buildDunePackage {
  pname = "octez-bls12-381-hash";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    bls12-381
    eqaf
  ];

  checkInputs = [
    tezt
    octez-alcotezt
    bisect_ppx
    alcotest
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Implementation of some cryptographic hash primitives using the scalar field of BLS12-381";
    };
}
