{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-lwt-result-stdlib,
  tezos-stdlib-unix,
  tezos-error-monad,
  re,
  lwt,
  alcotest,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-clic";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-lwt-result-stdlib tezos-stdlib-unix tezos-error-monad re lwt tezos-stdlib];

  checkInputs = [alcotest alcotest-lwt];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented command-line-parsing combinators";
    };
}
