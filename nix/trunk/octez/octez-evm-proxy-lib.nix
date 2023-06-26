{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-rpc-http,
  tezos-rpc-http-client-unix,
  tezos-version,
  lwt-exit,
  rope,
  rlp,
}:
buildDunePackage rec {
  pname = "octez-evm-proxy-lib";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-rpc-http
    tezos-rpc-http-client-unix
    tezos-version
    lwt-exit
    rope
    rlp
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "An implementation of a subset of Ethereum JSON-RPC API for the EVM rollup";};
}
