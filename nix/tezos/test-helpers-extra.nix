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
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

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
