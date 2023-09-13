{ lib
, buildDunePackage
, octez-libs
, tezos-wasmer
,
}:
buildDunePackage {
  pname = "tezos-scoru-wasm-fast";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    tezos-wasmer
  ];

  checkInputs = [
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: WASM functionality for SCORU Fast Execution";
    };
}
