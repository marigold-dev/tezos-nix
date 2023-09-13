{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, tezos-client-base
, tezos-client-base-unix
, cohttp-lwt-unix
, octez-node-config
, prometheus-app
, tezos-dal-node-lib
, tezos-dac-lib
, tezos-dac-client-lib
, octez-injector
, tezos-version
, tezos-layer2-store
, octez-crawler
, octez-smart-rollup
}:
buildDunePackage {
  pname = "octez-smart-rollup-node-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    tezos-client-base
    tezos-client-base-unix
    cohttp-lwt-unix
    octez-node-config
    prometheus-app
    tezos-dal-node-lib
    tezos-dac-lib
    tezos-dac-client-lib
    octez-injector
    tezos-version
    tezos-layer2-store
    octez-crawler
    octez-smart-rollup
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: library for Smart Rollup node";
    };
}
