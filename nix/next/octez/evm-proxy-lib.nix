{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, tezos-version
, lwt-exit
, rlp
, rope
}:
buildDunePackage {
  pname = "octez-evm-proxy-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    tezos-version
    lwt-exit
    rlp
    rope
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "An implementation of a subset of Ethereum JSON-RPC API for the EVM rollup";
    };
}
