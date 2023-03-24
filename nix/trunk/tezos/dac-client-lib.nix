{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-client-base,
  tezos-client-base-unix,
  tezos-stdlib-unix,
  tezos-dac-lib,
}:
buildDunePackage {
  pname = "tezos-dac-client-lib";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-client-base
    tezos-client-base-unix
    tezos-stdlib-unix
    tezos-dac-lib
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: `tezos-dac-client` library";
    };
}
