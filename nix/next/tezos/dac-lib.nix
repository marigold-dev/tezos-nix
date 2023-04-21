{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-protocol-updater,
}:
buildDunePackage {
  pname = "tezos-dac-lib";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-protocol-updater
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: `tezos-dac` library";
    };
}
