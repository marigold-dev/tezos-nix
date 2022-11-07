{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  resto-directory,
  resto-cohttp,
}:
buildDunePackage {
  pname = "tezos-rpc-http";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-base resto-directory resto-cohttp];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented RPCs (http server and client)";
    };
}
