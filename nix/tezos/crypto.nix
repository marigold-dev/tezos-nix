{ lib
, fetchpatch
, buildDunePackage
, tezos-stdlib
, tezos-rpc
, tezos-clic
, tezos-hacl
, tezos-bls12-381-polynomial
, secp256k1-internal
, ringo
, bls12-381
, tezos-test-helpers
, alcotest-lwt
}:

buildDunePackage {
  pname = "tezos-crypto";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs =
    [ tezos-rpc tezos-clic tezos-hacl secp256k1-internal ringo bls12-381 tezos-bls12-381-polynomial ];

  checkInputs = [ tezos-test-helpers alcotest-lwt ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: library with all the cryptographic primitives used by Tezos";
  };
}
