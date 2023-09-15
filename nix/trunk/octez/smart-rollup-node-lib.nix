{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, octez-shell-libs
, cohttp-lwt-unix
, octez-node-config
, prometheus-app
, tezos-dal-node-lib
, tezos-dac-lib
, tezos-dac-client-lib
, octez-injector
, tezos-version
, octez-l2-libs
, octez-crawler
}:
buildDunePackage {
  pname = "octez-smart-rollup-node-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    octez-shell-libs
    cohttp-lwt-unix
    octez-node-config
    prometheus-app
    tezos-dal-node-lib
    tezos-dac-lib
    tezos-dac-client-lib
    octez-injector
    tezos-version
    octez-l2-libs
    octez-crawler
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: library for Smart Rollup node";
    };
}
