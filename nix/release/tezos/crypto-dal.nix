{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-error-monad,
  data-encoding,
  tezos-crypto,
  tezos-bls12-381-polynomial,
  lwt,
  alcotest,
  qcheck-alcotest,
}:
buildDunePackage {
  pname = "tezos-crypto-dal";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-stdlib
    tezos-error-monad
    data-encoding
    tezos-crypto
    tezos-bls12-381-polynomial
    lwt
  ];

  checkInputs = [
    alcotest
    qcheck-alcotest
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library with all the cryptographic primitives used by Tezos";
    };
}
