{ lib
, buildDunePackage
, cacert
, octez-libs
, tezos-dal-node-services
, tezos-client-base
, tezos-protocol-updater
, tezos-client-base-unix
, alcotest-lwt
,
}:
buildDunePackage {
  pname = "tezos-dal-node-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-dal-node-services
    tezos-client-base
    tezos-protocol-updater
    tezos-client-base-unix
  ];

  checkInputs = [
    octez-libs
    alcotest-lwt
    cacert
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}
