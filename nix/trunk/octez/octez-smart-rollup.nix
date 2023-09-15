{
  lib,
  buildDunePackage,
  octez-libs,
  tezos-base,
  octez-libs-unix,
  tezos-crypto,
  tezos-crypto-dal,
}:
buildDunePackage rec {
  pname = "octez-smart-rollup";
  inherit (octez-libs) version src postPatch;

  propagatedBuildInputs = [
    tezos-base
    octez-libs-unix
    tezos-crypto
    tezos-crypto-dal
  ];

  doCheck = true;

  meta = octez-libs.meta // {description = "Octez: library for Smart Rollups";};
}
