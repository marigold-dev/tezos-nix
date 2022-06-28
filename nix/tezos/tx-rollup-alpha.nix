{ lib
, buildDunePackage
, ocaml
, tezos-stdlib
, index
, tezos-base
, tezos-crypto
, tezos-client-commands
, tezos-context
, tezos-alpha
, tezos-stdlib-unix
, tezos-rpc
, tezos-rpc-http
, tezos-rpc-http-client-unix
, tezos-rpc-http-server
, tezos-micheline
, tezos-client-base
, tezos-client-base-unix
, tezos-shell
, tezos-store
, tezos-workers
}:

buildDunePackage {
  pname = "tezos-tx-rollup-alpha";
  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/proto_alpha/lib_tx_rollup";

  minimalOCamlVersion = "4.12";

  propagatedBuildInputs =
    [
      index
      tezos-alpha.baking-commands
      tezos-alpha.client
      tezos-alpha.injector
      tezos-alpha.protocol
      tezos-alpha.protocol-plugin
      tezos-base
      tezos-client-base
      tezos-client-base-unix
      tezos-client-commands
      tezos-context
      tezos-crypto
      tezos-micheline
      tezos-rpc
      tezos-rpc-http
      tezos-rpc-http-client-unix
      tezos-rpc-http-server
      tezos-shell
      tezos-stdlib-unix
      tezos-store
      tezos-workers
    ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description = "Tezos: economic-protocol compiler";
  };
}
