{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-stdlib-unix,
  tezos-base,
  irmin,
  irmin-pack,
  bigstringaf,
  digestif,
  fmt,
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
    tezos-stdlib
    tezos-stdlib-unix
    tezos-base
    irmin
    irmin-pack
    bigstringaf
    digestif
    fmt
  ];

  checkInputs = [alcotest-lwt tezos-test-helpers tezos-test-helpers-extra];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented RPCs (service and hierarchy descriptions)";
    };
}
