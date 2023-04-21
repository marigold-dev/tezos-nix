{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-client-base,
  tezos-client-base-unix,
  tezos-stdlib-unix,
  tezos-layer2-store,
  tezos-rpc-http-server,
  tezos-dac-lib,
  tezos-dac-client-lib,
}:
buildDunePackage {
  pname = "tezos-dac-node-lib";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-client-base
    tezos-client-base-unix
    tezos-stdlib-unix
    tezos-layer2-store
    tezos-rpc-http-server
    tezos-dac-lib
    tezos-dac-client-lib
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: `tezos-dac-node` library";
    };
}
