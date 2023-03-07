{
  lib,
  buildDunePackage,
  cacert,
  tezos-stdlib,
  tezos-base,
  tezos-dal-node-services,
  tezos-client-base,
  tezos-protocol-updater,
  tezos-client-base-unix,
  tezos-stdlib-unix,
  tezos-crypto-dal,
  tezos-test-helpers,
  tezos-base-test-helpers,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-dal-node-lib";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-dal-node-services
    tezos-client-base
    tezos-protocol-updater
    tezos-client-base-unix
    tezos-stdlib-unix
    tezos-crypto-dal
  ];

  checkInputs = [
    tezos-stdlib
    tezos-test-helpers
    tezos-base-test-helpers
    alcotest-lwt
    cacert
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}
