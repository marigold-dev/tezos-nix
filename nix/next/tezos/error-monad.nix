{
  lib,
  buildDunePackage,
  tezos-stdlib,
  data-encoding,
  lwt,
  lwt-canceler,
  tezos-lwt-result-stdlib,
  alcotest,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-error-monad";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-stdlib data-encoding lwt lwt-canceler tezos-lwt-result-stdlib];

  checkInputs = [alcotest alcotest-lwt];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "Tezos: error monad";};
}
