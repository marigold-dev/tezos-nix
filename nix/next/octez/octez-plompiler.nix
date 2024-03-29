{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  ppx_repr,
  repr,
  stdint,
  hacl-star,
  octez-bls12-381-hash,
  octez-polynomial,
  octez-mec,
  alcotest,
}:
buildDunePackage {
  pname = "octez-plompiler";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ppx_repr
    repr
    stdint
    hacl-star
    octez-bls12-381-hash
    octez-polynomial
    octez-mec
  ];

  doCheck = true;

  checkInputs = [alcotest];

  meta =
    tezos-stdlib.meta
    // {
      description = "Library to write arithmetic circuits for Plonk";
    };
}
