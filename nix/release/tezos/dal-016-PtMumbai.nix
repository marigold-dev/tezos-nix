{
  lib,
  buildDunePackage,
  cacert,
  tezos-stdlib,
  ppx_expect,
  tezos-base,
  octez-protocol-compiler,
  tezos-stdlib-unix,
  tezos-dal-node-lib,
  tezos-base-test-helpers,
  tezos-016-PtMumbai,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-dal-016-PtMumbai";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    octez-protocol-compiler
    tezos-stdlib-unix
    tezos-dal-node-lib
    tezos-016-PtMumbai.layer2-utils
    tezos-016-PtMumbai.protocol
    tezos-016-PtMumbai.protocol-plugin
    tezos-016-PtMumbai.embedded-protocol
    tezos-016-PtMumbai.client
  ];

  buildInputs = [ppx_expect];

  checkInputs = [
    tezos-base-test-helpers
    tezos-016-PtMumbai.test-helpers
    alcotest-lwt
    cacert
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: layer2 storage utils";
    };
}
