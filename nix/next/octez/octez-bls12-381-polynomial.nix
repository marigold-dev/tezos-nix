{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  ppx_repr,
  bls12-381,
  bigstringaf,
  tezt,
  octez-alcotezt,
  qcheck-alcotest,
  octez-polynomial,
  bisect_ppx,
}:
buildDunePackage {
  pname = "octez-bls12-381-polynomial";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

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
    tezos-stdlib.meta
    // {
      description = "Implementation of BLS signatures for the pairing-friendly curve BLS12-381";
    };
}
