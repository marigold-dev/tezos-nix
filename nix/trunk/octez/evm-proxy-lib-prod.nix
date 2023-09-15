{ lib
, buildDunePackage
, octez-libs
, tezos-version
, lwt-exit
}:
buildDunePackage rec {
  pname = "octez-evm-proxy-lib-prod";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    tezos-version
    lwt-exit
  ];

  doCheck = true;

  meta = octez-libs.meta // { description = "An implementation of a subset of Ethereum JSON-RPC API for the EVM rollup"; };
}
