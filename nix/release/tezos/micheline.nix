{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-error-monad,
  uutf,
  alcotest,
  alcotest-lwt,
  ppx_inline_test,
}:
buildDunePackage {
  pname = "tezos-micheline";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-error-monad uutf ppx_inline_test];

  checkInputs = [alcotest alcotest-lwt];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: internal AST and parser for the Michelson language";
    };
}
