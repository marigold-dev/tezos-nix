{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-webassembly-interpreter,
  tezos-lazy-containers,
  lwt,
}:
buildDunePackage {
  pname = "tezos-webassembly-interpreter-extra";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-webassembly-interpreter
    tezos-lazy-containers
    lwt
  ];

  checkInputs = [
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: WebAssembly reference interpreter with tweaks for Tezos";
    };
}
