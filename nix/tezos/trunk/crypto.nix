{ lib, buildDunePackage, tezos-stdlib, tezos-rpc, tezos-clic, tezos-hacl
, secp256k1-internal, ringo, bls12-381, tezos-test-helpers, alcotest-lwt }:

buildDunePackage {
  pname = "tezos-crypto";
  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/lib_crypto";

  propagatedBuildInputs =
    [ tezos-rpc tezos-clic tezos-hacl secp256k1-internal ringo bls12-381 ];

  checkInputs = [ tezos-test-helpers alcotest-lwt ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: library with all the cryptographic primitives used by Tezos";
  };
}
