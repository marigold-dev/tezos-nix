{ lib, buildDunePackage, tezos-stdlib, tezos-hacl-glue, ctypes, hacl-star, tezos-test-helpers, data-encoding, zarith_stubs_js, tezos-error-monad }:

buildDunePackage {
  pname = "tezos-hacl-glue-unix";

  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/lib_hacl_glue/unix";

  propagatedBuildInputs = [ ctypes hacl-star tezos-hacl-glue ];
  checkInputs = [
    tezos-test-helpers
    data-encoding
    zarith_stubs_js
    tezos-error-monad
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: thin layer of glue around hacl-star (unix implementation)";
  };
}
