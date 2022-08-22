{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-shell-services,
  irmin,
  irmin-pack,
  digestif,
  alcotest-lwt,
  tezos-test-helpers,
  tezos-test-helpers-extra,
}:
buildDunePackage {
  pname = "tezos-context";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    tezos-base
    tezos-shell-services
    irmin
    irmin-pack
    digestif
    # Not sure why these have to be here...
    tezos-test-helpers
    tezos-test-helpers-extra
  ];

  checkInputs = [alcotest-lwt tezos-test-helpers tezos-test-helpers-extra];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented RPCs (service and hierarchy descriptions)";
    };
}
