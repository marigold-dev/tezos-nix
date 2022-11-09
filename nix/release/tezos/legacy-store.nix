{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-context,
  tezos-lmdb,
  tezos-validation,
  tezos-shell-services,
  octez-protocol-compiler,
  lwt-watcher,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-legacy-store";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  postPatch = ''
    rm -rf vendors
  '';

  propagatedBuildInputs = [
    tezos-context
    tezos-lmdb
    tezos-validation
    tezos-shell-services
    lwt-watcher
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
