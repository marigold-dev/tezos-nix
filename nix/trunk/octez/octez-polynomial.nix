{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  bls12-381,
  zarith,
  tezt,
  octez-mec,
  octez-alcotezt,
  bisect_ppx,
}:
buildDunePackage {
  pname = "octez-polynomial";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    bls12-381
    zarith
  ];

  checkInputs = [
    tezt
    octez-alcotezt
    octez-mec
    bisect_ppx
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Polynomials over finite fields";
    };
}
