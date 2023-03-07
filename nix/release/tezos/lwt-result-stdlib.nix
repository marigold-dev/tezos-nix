{
  lib,
  buildDunePackage,
  ocaml,
  tezos-stdlib,
  lwt,
  qcheck-alcotest,
  alcotest-lwt,
  tezos-test-helpers,
  ppx_inline_test,
}:
buildDunePackage {
  pname = "tezos-lwt-result-stdlib";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  minimalOCamlVersion = "4.12";

  propagatedBuildInputs = [lwt];

  buildInputs = [ppx_inline_test];

  checkInputs = [alcotest-lwt qcheck-alcotest tezos-test-helpers];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: error-aware stdlib replacement";
    };
}
