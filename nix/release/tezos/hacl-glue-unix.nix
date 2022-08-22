{ lib
, buildDunePackage
, tezos-stdlib
, tezos-hacl-glue
, ctypes
, hacl-star
, tezos-test-helpers
, data-encoding
, zarith_stubs_js
, tezos-error-monad
}:

buildDunePackage {
  pname = "tezos-hacl-glue-unix";

  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ ctypes hacl-star tezos-hacl-glue ];
  checkInputs =
    [ tezos-test-helpers data-encoding zarith_stubs_js tezos-error-monad ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: thin layer of glue around hacl-star (unix implementation)";
  };
}
