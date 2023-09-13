{ lib
, buildDunePackage
, octez-libs
, ppx_import
, ppx_deriving
, tezos-scoru-wasm-fast
, qcheck-alcotest
, alcotest-lwt
, tezt
, tezos-webassembly-interpreter-extra
,
}:
buildDunePackage {
  pname = "tezos-scoru-wasm-helpers";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    ppx_import
    ppx_deriving
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
    octez-libs.meta
    // {
      description = "Tezos: Helpers for the smart rollup wasm functionality and debugger";
    };
}
