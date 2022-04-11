{ lib, fetchFromGitLab, buildDunePackage, qcheck-alcotest, alcotest
, alcotest-lwt, uri, tezos-stdlib, pure-splitmix, data-encoding }:

buildDunePackage rec {
  pname = "tezos-test-helpers";
  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/lib_test";

  propagatedBuildInputs =
    [ qcheck-alcotest alcotest alcotest-lwt uri pure-splitmix data-encoding ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: yet-another local-extension of the OCaml standard library";
  };
}
