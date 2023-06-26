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
  alcotest-lwt,
  qcheck-alcotest,
}:
buildDunePackage {
  pname = "tezos-stdlib-unix";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-event-logging re ptime mtime_1 ipaddr ezjsonm fmt];
  checkInputs = [alcotest-lwt qcheck-alcotest];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: yet-another local-extension of the OCaml standard library (unix-specific fragment)";
    };
}
