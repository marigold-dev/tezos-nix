{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  ppx_repr,
  repr,
  hacl-star,
  data-encoding,
  octez-bls12-381-polynomial,
  octez-polynomial,
  octez-plompiler,
  logs,
  octez-distributed-lwt-internal,
  bls12-381,
  qcheck-alcotest,
}:
buildDunePackage {
  pname = "octez-plonk";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ppx_repr
    repr
    hacl-star
    data-encoding
    octez-bls12-381-polynomial
    octez-polynomial
    octez-plompiler
    logs
    octez-distributed-lwt-internal
    bls12-381
  ];

  doCheck = true;

  checkInputs = [qcheck-alcotest];

  meta =
    tezos-stdlib.meta
    // {
      description = "Plonk zero-knowledge proving system";
    };
}
