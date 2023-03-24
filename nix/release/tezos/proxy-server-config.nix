{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-stdlib-unix,
  uri,
  tezos-test-helpers,
  qcheck-alcotest,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-proxy-server-config";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    uri
  ];

  checkInputs = [
    tezos-test-helpers
    qcheck-alcotest
    alcotest-lwt
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: proxy server configuration";
    };
}
