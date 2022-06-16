{ lib
, buildDunePackage
, tezos-stdlib
, tezos-base
, tezos-crypto
, tezos-test-helpers
, tezos-shell-services
}:

buildDunePackage rec {
  pname = "tezos-test-helpers-extra";
  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/lib_test";

  propagatedBuildInputs =
    [
      tezos-base
      tezos-crypto
      tezos-test-helpers
      tezos-shell-services
    ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: yet-another local-extension of the OCaml standard library";
  };
}
