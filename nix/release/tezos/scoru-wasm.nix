{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-webassembly-interpreter,
  tezos-context,
  tezos-lwt-result-stdlib,
  data-encoding,
}:
buildDunePackage {
  pname = "tezos-scoru-wasm";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    tezos-base
    tezos-webassembly-interpreter
    tezos-context
    tezos-lwt-result-stdlib
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
