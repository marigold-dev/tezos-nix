{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-error-monad,
  tezos-crypto,
  tezos-micheline,
  tezos-alpha,
  zarith,
  zarith_stubs_js,
  tezt,
}:
buildDunePackage {
  pname = "tezos-micheline-rewriting";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [zarith zarith_stubs_js tezos-stdlib tezos-crypto tezos-error-monad tezos-micheline];

  checkInputs = [tezos-alpha.protocol tezos-alpha.client tezt];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library for rewriting Micheline expressions";
    };
}
