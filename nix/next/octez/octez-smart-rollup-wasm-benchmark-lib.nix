{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, ppx_deriving
, tezt
, tezos-scoru-wasm-helpers
, lwt
,
}:
buildDunePackage {
  pname = "octez-smart-rollup-wasm-benchmark-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    ppx_deriving
    tezt
    tezos-scoru-wasm-helpers
    lwt
  ];

  checkInputs = [
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: library with all the cryptographic primitives used by Tezos";
    };
}
