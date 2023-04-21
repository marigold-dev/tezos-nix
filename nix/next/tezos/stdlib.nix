{
  lib,
  src,
  aches,
  aches-lwt,
  alcotest,
  alcotest-lwt,
  bigstring,
  buildDunePackage,
  crowbar,
  hex,
  lwt,
  lwt_log,
  ppx_expect,
  qcheck-alcotest,
  ringo,
  tezos-test-helpers,
  version,
  zarith,
  zarith_stubs_js,
}:
buildDunePackage rec {
  pname = "tezos-stdlib";

  inherit src version;

  minimalOCamlVersion = "4.08";

  duneVersion = "3";

  postPatch = ''
    rm -rf vendors
  '';

  propagatedBuildInputs = [hex lwt zarith ppx_expect zarith_stubs_js ringo aches aches-lwt];

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
    description = "Tezos: yet-another local-extension of the OCaml standard library";
    license = lib.licenses.mit;
    maintainers = [lib.maintainers.ulrikstrid];
  };
}
