{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-rpc,
  tezos-crypto-dal,
}:
buildDunePackage {
  pname = "tezos-dal-node-services";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-rpc
    tezos-crypto-dal
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}
