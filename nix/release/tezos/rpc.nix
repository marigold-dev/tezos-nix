{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-error-monad,
  resto,
  resto-directory,
}:
buildDunePackage {
  pname = "tezos-rpc";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-error-monad resto resto-directory];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented RPCs (service and hierarchy descriptions)";
    };
}
