{
  lib,
  ocaml,
  buildDunePackage,
  tezos-stdlib,
  tezos-crypto,
  tezos-crypto-dal,
  tezos-lwt-result-stdlib,
  tezos-scoru-wasm,
  data-encoding,
  bls12-381,
  tezos-plonk,
  zarith,
  zarith_stubs_js,
  class_group_vdf,
  ringo,
  ringo-lwt,
  tezos-base,
  tezos-sapling,
  tezos-micheline,
  tezos-context,
  tezos-event-logging,
  alcotest-lwt,
  tezos-test-helpers,
}:
buildDunePackage {
  pname = "tezos-protocol-environment";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-stdlib
    tezos-crypto
    tezos-crypto-dal
    tezos-lwt-result-stdlib
    tezos-scoru-wasm

    data-encoding
    bls12-381
    tezos-plonk
    zarith
    zarith_stubs_js
    class_group_vdf
    ringo
    ringo-lwt

    tezos-base
    tezos-sapling
    tezos-micheline
    tezos-context
    tezos-event-logging
  ];

  checkInputs = [alcotest-lwt tezos-test-helpers];

  forceShare = "man info";

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: custom economic-protocols environment implementation for `octez-client` and testing";
    };
}
