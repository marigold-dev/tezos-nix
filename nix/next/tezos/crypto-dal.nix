{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-error-monad,
  data-encoding,
  tezos-crypto,
  octez-bls12-381-polynomial,
  tezos-test-helpers,
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
    octez-bls12-381-polynomial
    lwt
  ];

  checkInputs = [
    alcotest
    qcheck-alcotest
    tezos-test-helpers
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library with all the cryptographic primitives used by Tezos";
    };
}
