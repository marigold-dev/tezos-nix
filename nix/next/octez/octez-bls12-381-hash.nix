{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  bls12-381,
  eqaf,
  bisect_ppx,
  alcotest,
  tezt,
  octez-alcotezt,
}:
buildDunePackage {
  pname = "octez-bls12-381-hash";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

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
    tezos-stdlib.meta
    // {
      description = "Implementation of some cryptographic hash primitives using the scalar field of BLS12-381";
    };
}
