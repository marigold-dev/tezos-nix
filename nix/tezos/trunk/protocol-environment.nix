{ lib, ocaml, buildDunePackage, bls12-381, bls12-381-legacy, tezos-stdlib
, tezos-base, tezos-sapling, tezos-context, tezos-test-helpers, zarith
, alcotest-lwt, ringo-lwt }:

buildDunePackage {
  pname = "tezos-protocol-environment";
  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/lib_protocol_environment";

  propagatedBuildInputs = [
    bls12-381
    bls12-381-legacy
    tezos-sapling
    tezos-base
    tezos-context
    zarith
    ringo-lwt
  ];

  checkInputs = [ alcotest-lwt tezos-test-helpers ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: custom economic-protocols environment implementation for `tezos-client` and testing";
  };
}
