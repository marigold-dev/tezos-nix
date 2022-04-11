{ lib, buildDunePackage, tezos-stdlib, hacl-star, hacl-star-raw, ctypes_stubs_js, integers_stubs_js, tezos-test-helpers, tezos-error-monad }:

buildDunePackage {
  pname = "tezos-hacl";

  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/lib_hacl";

  doCheck = true;

  propagatedBuildInputs = [
    ctypes_stubs_js
    hacl-star
    hacl-star-raw
  ];

  checkInputs = [
    tezos-test-helpers
    tezos-error-monad
  ];

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: thin layer of glue around hacl-star (virtual package)";
  };
}
