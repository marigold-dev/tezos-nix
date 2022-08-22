{
  lib,
  ocaml,
  buildDunePackage,
  bls12-381,
  bls12-381-legacy,
  tezos-stdlib,
  tezos-base,
  tezos-sapling,
  tezos-context,
  tezos-test-helpers,
  tezos-plonk,
  tezos-scoru-wasm,
  zarith,
  alcotest-lwt,
  ringo-lwt,
  class_group_vdf,
}:
buildDunePackage {
  pname = "tezos-protocol-environment";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    bls12-381
    bls12-381-legacy
    tezos-sapling
    tezos-base
    tezos-context
    tezos-plonk
    tezos-scoru-wasm
    zarith
    ringo-lwt
    class_group_vdf
  ];

  checkInputs = [alcotest-lwt tezos-test-helpers];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: custom economic-protocols environment implementation for `tezos-client` and testing";
    };
}
