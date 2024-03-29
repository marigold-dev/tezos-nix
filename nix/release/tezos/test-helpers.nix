{
  lib,
  fetchFromGitLab,
  buildDunePackage,
  qcheck-alcotest,
  alcotest,
  alcotest-lwt,
  uri,
  tezos-stdlib,
  pure-splitmix,
  data-encoding,
  ppx_inline_test,
}:
buildDunePackage rec {
  pname = "tezos-test-helpers";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [qcheck-alcotest alcotest alcotest-lwt uri pure-splitmix data-encoding];

  buildInputs = [ppx_inline_test];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: yet-another local-extension of the OCaml standard library";
    };
}
