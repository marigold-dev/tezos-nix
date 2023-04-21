{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-crypto,
  tezos-test-helpers,
  tezos-shell-services,
}:
buildDunePackage rec {
  pname = "tezos-test-helpers-extra";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-crypto
    tezos-test-helpers
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: yet-another local-extension of the OCaml standard library";
    };
}
