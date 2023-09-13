{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, lwt
,
}:
buildDunePackage {
  pname = "tezos-webassembly-interpreter-extra";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    lwt
  ];

  checkInputs = [
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: WebAssembly reference interpreter with tweaks for Tezos";
    };
}
