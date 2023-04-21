{
  lib,
  buildDunePackage,
  tezos-stdlib,
  ppxlib,
  ppx_deriving,
  ctypes,
  lwt,
  tezos-rust-libs,
}:
buildDunePackage {
  pname = "tezos-wasmer";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ppx_deriving
    ppxlib
    ctypes
    lwt
    tezos-rust-libs
  ];

  checkInputs = [
  ];

  doCheck = true;

  # This is a hack to work around the hack used in the dune files
  OPAM_SWITCH_PREFIX = "${tezos-rust-libs}";

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: Wasmer bindings for SCORU WASM";
    };
}
