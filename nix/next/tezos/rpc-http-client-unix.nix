{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-rpc-http-client,
  cohttp-lwt-unix,
}:
buildDunePackage {
  pname = "tezos-rpc-http-client-unix";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-rpc-http-client cohttp-lwt-unix];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: unix implementation of the RPC client";
    };
}
