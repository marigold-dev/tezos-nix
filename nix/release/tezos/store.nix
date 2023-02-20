{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-protocol-updater,
  tezos-validation,
  octez-protocol-compiler,
  index,
  camlzip,
  tar-unix,
  digestif,
  alcotest-lwt,
  lwt-watcher,
  prometheus,
}:
buildDunePackage {
  pname = "tezos-store";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    index
    camlzip
    tar-unix
    digestif
    lwt-watcher
    tezos-protocol-updater
    tezos-validation
    prometheus
  ];

  nativeBuildInputs = [octez-protocol-compiler];

  strictDeps = true;

  checkInputs = [alcotest-lwt];

  # A lot of extra deps with wide dependency cones needed
  doCheck = false;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: custom economic-protocols environment implementation for `octez-client` and testing";
    };
}
