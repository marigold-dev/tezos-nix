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
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [tezos-error-monad resto resto-directory];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented RPCs (service and hierarchy descriptions)";
    };
}
