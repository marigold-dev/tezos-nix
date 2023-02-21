{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  irmin-pack,
  irmin,
  aches-lwt,
  tezos-stdlib-unix,
  tezos-context,
  tezos-error-monad,
  qcheck-alcotest,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-layer2-store";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    irmin-pack
    irmin
    aches-lwt
    tezos-stdlib-unix
    tezos-context
  ];

  checkInputs = [
    tezos-error-monad
    qcheck-alcotest
    alcotest-lwt
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: layer2 storage utils";
    };
}
