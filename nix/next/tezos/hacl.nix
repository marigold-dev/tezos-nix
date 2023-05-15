{
  lib,
  buildDunePackage,
  tezos-stdlib,
  hacl-star,
  hacl-star-raw,
  ctypes_stubs_js,
  integers_stubs_js,
  tezos-test-helpers,
  tezos-error-monad,
  octez-alcotezt,
  qcheck-alcotest,
}:
buildDunePackage {
  pname = "tezos-hacl";

  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  doCheck = true;

  propagatedBuildInputs = [ctypes_stubs_js hacl-star hacl-star-raw];

  checkInputs = [octez-alcotezt qcheck-alcotest tezos-test-helpers tezos-error-monad];

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: thin layer of glue around hacl-star (virtual package)";
    };
}
