{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-client-base,
  tezos-protocol-environment,
  tezos-rpc-http-client,
  resto-cohttp-self-serving-client,
}:
buildDunePackage {
  pname = "tezos-mockup-proxy";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-client-base
    tezos-protocol-environment
    tezos-rpc-http-client
    resto-cohttp-self-serving-client
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "Tezos: local RPCs";};
}
