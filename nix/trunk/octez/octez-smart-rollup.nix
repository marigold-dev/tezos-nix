{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-stdlib-unix,
  tezos-crypto,
  tezos-crypto-dal,
}:
buildDunePackage rec {
  pname = "octez-smart-rollup";
  inherit (tezos-stdlib) version src postPatch;

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    tezos-crypto
    tezos-crypto-dal
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "Octez: library for Smart Rollups";};
}
