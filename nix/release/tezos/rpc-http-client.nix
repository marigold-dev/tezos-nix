{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-rpc-http,
  resto-cohttp-client,
}:
buildDunePackage {
  pname = "tezos-rpc-http-client";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-rpc-http resto-cohttp-client];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented RPCs (http client)";
    };
}
