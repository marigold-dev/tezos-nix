{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-stdlib-unix,
  alcotest,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-clic";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-stdlib-unix];

  checkInputs = [alcotest alcotest-lwt];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented command-line-parsing combinators";
    };
}
