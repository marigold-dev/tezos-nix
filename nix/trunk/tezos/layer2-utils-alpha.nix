{
  lib,
  buildDunePackage,
  tezos-stdlib,
  ppx_expect,
  tezos-base,
  tezos-alpha,
  tezos-rpc,
}:
buildDunePackage {
  pname = "tezos-layer2-utils-alpha";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ppx_expect
    tezos-base
    tezos-alpha.protocol
    tezos-alpha.client
    tezos-rpc
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos/Protocol: protocol specific library for Layer 2 utils";
    };
}
