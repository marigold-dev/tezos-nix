{ lib
, buildDunePackage
, tezos-stdlib
, tezos-protocol-updater
, tezos-validation
, tezos-protocol-compiler
, index
, camlzip
, tar-unix
, ringo-lwt
, digestif
, alcotest-lwt
, lwt-watcher
, prometheus
}:

buildDunePackage {
  pname = "tezos-store";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    index
    camlzip
    tar-unix
    ringo-lwt
    digestif
    lwt-watcher
    tezos-protocol-updater
    tezos-validation
    prometheus
  ];

  nativeBuildInputs = [ tezos-protocol-compiler ];

  strictDeps = true;

  checkInputs = [ alcotest-lwt ];

  # A lot of extra deps with wide dependency cones needed
  doCheck = false;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: custom economic-protocols environment implementation for `tezos-client` and testing";
  };
}
