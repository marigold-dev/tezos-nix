{
  lib,
  buildDunePackage,
  tezos-stdlib,
  ppx_repr,
  bls12-381,
  bigstringaf,
  alcotest,
  qcheck-alcotest,
  polynomial,
  bisect_ppx,
}:
buildDunePackage {
  pname = "tezos-bls12-381-polynomial-internal";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [ppx_repr bls12-381 bigstringaf];

  checkInputs = [alcotest qcheck-alcotest polynomial bisect_ppx];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Polynomials over BLS12-381 finite field - Temporary vendored version of Octez";
    };
}
