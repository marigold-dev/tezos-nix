{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-lwt-result-stdlib,
  tezos-hacl,
  tezos-error-monad,
  tezos-rpc,
  secp256k1-internal,
  data-encoding,
  lwt,
  aches,
  zarith,
  zarith_stubs_js,
  bls12-381,
  octez-bls12-381-signature,
  tezt,
  octez-alcotezt,
  qcheck-alcotest,
  tezos-test-helpers,
}:
buildDunePackage {
  pname = "tezos-crypto";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-stdlib
    tezos-lwt-result-stdlib
    tezos-hacl
    tezos-error-monad
    tezos-rpc

    secp256k1-internal
    data-encoding
    lwt
    aches
    zarith
    zarith_stubs_js
    bls12-381
    octez-bls12-381-signature
  ];

  checkInputs = [
    tezt
    octez-alcotezt
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
