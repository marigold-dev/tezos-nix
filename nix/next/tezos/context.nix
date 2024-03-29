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
  tezt,
  octez-alcotezt,
  qcheck-alcotest,
  tezos-test-helpers,
}:
buildDunePackage {
  pname = "tezos-context";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

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

  checkInputs = [tezt octez-alcotezt qcheck-alcotest tezos-test-helpers];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented RPCs (service and hierarchy descriptions)";
    };
}
