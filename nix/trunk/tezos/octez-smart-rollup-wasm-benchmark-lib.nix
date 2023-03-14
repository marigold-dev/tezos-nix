{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  ppx_deriving,
  tezos-base,
  tezt,
  tezos-webassembly-interpreter,
  tezos-context,
  tezos-scoru-wasm,
  tezos-scoru-wasm-helpers,
  lwt,
}:
buildDunePackage {
  pname = "octez-smart-rollup-wasm-benchmark-lib";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ppx_deriving
    tezos-base
    tezt
    tezos-webassembly-interpreter
    tezos-context
    tezos-scoru-wasm
    tezos-scoru-wasm-helpers
    lwt
  ];

  checkInputs = [
  ];

  doCheck = false;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library with all the cryptographic primitives used by Tezos";
    };
}
