{ lib
, buildDunePackage
, cacert
, octez-libs
, ppx_expect
, octez-protocol-compiler
, tezos-dal-node-lib
, tezos-016-PtMumbai
, alcotest-lwt
,
}:
buildDunePackage {
  pname = "tezos-dal-016-PtMumbai";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-protocol-compiler
    tezos-dal-node-lib
    tezos-016-PtMumbai.layer2-utils
    tezos-016-PtMumbai.protocol
    tezos-016-PtMumbai.protocol-plugin
    tezos-016-PtMumbai.embedded-protocol
    tezos-016-PtMumbai.client
  ];

  buildInputs = [ ppx_expect ];

  checkInputs = [
    tezos-016-PtMumbai.test-helpers
    alcotest-lwt
    cacert
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: layer2 storage utils";
    };
}
