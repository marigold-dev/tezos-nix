{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-event-logging,
  re,
  ptime,
  mtime_1,
  ipaddr,
  ezjsonm,
  fmt,
  tezt,
  octez-alcotezt,
  qcheck-alcotest,
  tezos-test-helpers,
}:
buildDunePackage {
  pname = "tezos-stdlib-unix";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-event-logging re ptime mtime_1 ipaddr ezjsonm fmt];
  checkInputs = [tezt octez-alcotezt qcheck-alcotest tezos-test-helpers];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: yet-another local-extension of the OCaml standard library (unix-specific fragment)";
    };
}
