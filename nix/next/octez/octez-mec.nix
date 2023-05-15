{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  bls12-381,
  eqaf,
  bigarray-compat,
  tezt,
  octez-alcotezt,
  alcotest,
}:
buildDunePackage {
  pname = "octez-mec";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    bls12-381
    eqaf
    bigarray-compat
    alcotest
  ];

  checkInputs = [
    tezt
    octez-alcotezt
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Modular Experimental Cryptography library";
    };
}
