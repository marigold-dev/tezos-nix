{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-webassembly-interpreter,
  tezos-context,
  tezos-lwt-result-stdlib,
  tezos-tree-encoding,
  data-encoding,
}:
buildDunePackage {
  pname = "tezos-scoru-wasm";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-webassembly-interpreter
    tezos-context
    tezos-lwt-result-stdlib
    tezos-tree-encoding
    data-encoding
  ];

  checkInputs = [];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: Protocol environment dependency providing WASM functionality for SCORU";
    };
}
