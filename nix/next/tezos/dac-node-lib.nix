{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, tezos-client-base
, tezos-client-base-unix
, tezos-layer2-store
, tezos-dac-lib
, tezos-dac-client-lib
,
}:
buildDunePackage {
  pname = "tezos-dac-node-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-client-base
    tezos-client-base-unix
    tezos-layer2-store
    tezos-dac-lib
    tezos-dac-client-lib
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dac-node` library";
    };
}
