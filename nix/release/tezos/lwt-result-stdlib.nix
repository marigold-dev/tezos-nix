{
  lib,
  buildDunePackage,
  ocaml,
  tezos-stdlib,
  lwt,
  alcotest-lwt,
  tezos-test-helpers,
  ppx_inline_test,
}:
buildDunePackage {
  pname = "tezos-lwt-result-stdlib";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  minimalOCamlVersion = "4.12";

  propagatedBuildInputs = [lwt];

  buildInputs = [ppx_inline_test];

  checkInputs = [alcotest-lwt tezos-test-helpers];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: error-aware stdlib replacement";
    };
}
