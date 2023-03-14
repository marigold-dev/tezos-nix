{
  lib,
  buildDunePackage,
  tezos-stdlib,
  ppx_import,
  ppx_deriving,
  tezos-base,
  tezos-tree-encoding,
  tezos-context,
  tezos-base-test-helpers,
  tezos-test-helpers,
  tezos-scoru-wasm,
  tezos-scoru-wasm-fast,
  qcheck-alcotest,
  alcotest-lwt,
  tezt,
  tezos-webassembly-interpreter-extra,
}:
buildDunePackage {
  pname = "tezos-scoru-wasm-helpers";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ppx_import
    ppx_deriving
    tezos-base
    tezos-tree-encoding
    tezos-context
    tezos-base-test-helpers
    tezos-test-helpers
    tezos-scoru-wasm
    tezos-scoru-wasm-fast
    qcheck-alcotest
    alcotest-lwt
    tezt
    tezos-webassembly-interpreter-extra
  ];

  checkInputs = [
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: Helpers for the smart rollup wasm functionality and debugger";
    };
}
