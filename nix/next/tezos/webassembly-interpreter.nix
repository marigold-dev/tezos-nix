{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-lwt-result-stdlib,
  tezos-lazy-containers,
  tezos-error-monad,
  zarith,
  ppxlib,
  ppx_deriving,
  qcheck-core,
  qcheck-alcotest,
  tezt,
  octez-alcotezt,
}:
buildDunePackage {
  pname = "tezos-webassembly-interpreter";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-lwt-result-stdlib
    zarith
    tezos-lazy-containers
    tezos-error-monad
    ppx_deriving
    ppxlib
  ];

  checkInputs = [
    qcheck-core
    qcheck-alcotest
    tezt
    octez-alcotezt
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: WebAssembly reference interpreter with tweaks for Tezos";
    };
}
