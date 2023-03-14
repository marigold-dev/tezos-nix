{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-tree-encoding,
  tezos-webassembly-interpreter,
  tezos-lazy-containers,
  tezos-scoru-wasm,
  tezos-wasmer,
}:
buildDunePackage {
  pname = "tezos-scoru-wasm-fast";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-tree-encoding
    tezos-webassembly-interpreter
    tezos-lazy-containers
    tezos-scoru-wasm
    tezos-wasmer
  ];

  checkInputs = [
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: WASM functionality for SCORU Fast Execution";
    };
}
