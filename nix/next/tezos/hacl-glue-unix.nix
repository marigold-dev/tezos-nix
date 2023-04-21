{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-hacl-glue,
  ctypes,
  hacl-star,
  tezos-test-helpers,
  data-encoding,
  zarith_stubs_js,
  tezos-error-monad,
}:
buildDunePackage {
  pname = "tezos-hacl-glue-unix";

  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [ctypes hacl-star tezos-hacl-glue];
  checkInputs = [tezos-test-helpers data-encoding zarith_stubs_js tezos-error-monad];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: thin layer of glue around hacl-star (unix implementation)";
    };
}
