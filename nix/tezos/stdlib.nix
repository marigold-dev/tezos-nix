{ lib, src, version, buildDunePackage, hex, lwt, zarith, alcotest, alcotest-lwt
, crowbar, zarith_stubs_js, bigstring, lwt_log, ppx_inline_test, qcheck-alcotest
, tezos-test-helpers }:

buildDunePackage rec {
  pname = "tezos-stdlib";

  base_src = src;

  inherit src version;

  minimalOCamlVersion = "4.08";

  useDune2 = true;

  preBuild = ''
    rm -rf vendors
  '';

  propagatedBuildInputs = [ hex lwt zarith ppx_inline_test zarith_stubs_js ];

  checkInputs = [
    bigstring
    lwt_log
    alcotest
    alcotest-lwt
    crowbar
    bigstring
    lwt_log
    qcheck-alcotest
    # tezos-test-helpers
  ];

  # circular dependency if we add this
  doCheck = false;

  meta = {
    description =
      "Tezos: yet-another local-extension of the OCaml standard library";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.ulrikstrid ];
  };
}
