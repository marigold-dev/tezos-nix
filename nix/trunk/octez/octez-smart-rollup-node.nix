{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-stdlib-unix,
  tezos-crypto,
  cohttp-lwt-unix,
  octez-node-config,
  prometheus-app,
  octez-injector,
}:
buildDunePackage {
  pname = "octez-smart-rollup-node";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    tezos-crypto
    cohttp-lwt-unix
    octez-node-config
    prometheus-app
    octez-injector
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Octez: library for Smart Rollup node";
    };
}
