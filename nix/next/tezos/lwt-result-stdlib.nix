{
  lib,
  buildDunePackage,
  ocaml,
  tezos-stdlib,
  lwt,
  seqes,
  qcheck-alcotest,
  octez-alcotezt,
  tezt,
  tezos-test-helpers,
  ppx_inline_test,
}:
buildDunePackage {
  pname = "tezos-lwt-result-stdlib";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  minimalOCamlVersion = "4.12";

  propagatedBuildInputs = [lwt seqes];

  buildInputs = [ppx_inline_test];

  checkInputs = [tezt octez-alcotezt qcheck-alcotest tezos-test-helpers];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: error-aware stdlib replacement";
    };
}
