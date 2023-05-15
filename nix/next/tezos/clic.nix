{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-lwt-result-stdlib,
  tezos-stdlib-unix,
  tezos-error-monad,
  re,
  lwt,
  tezt,
  octez-alcotezt,
}:
buildDunePackage {
  pname = "tezos-clic";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-lwt-result-stdlib tezos-stdlib-unix tezos-error-monad re lwt tezos-stdlib];

  checkInputs = [tezt octez-alcotezt];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented command-line-parsing combinators";
    };
}
