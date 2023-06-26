{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  bls12-381,
  integers_stubs_js,
  re,
  alcotest,
  tezt,
  octez-alcotezt,
}:
buildDunePackage {
  pname = "octez-bls12-381-signature";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    bls12-381
    integers_stubs_js
    re
  ];

  checkInputs = [
    alcotest
    tezt
    octez-alcotezt
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Implementation of BLS signatures for the pairing-friendly curve BLS12-381";
    };
}
