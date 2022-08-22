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
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [tezos-stdlib data-encoding lwt lwt-canceler tezos-lwt-result-stdlib];

  checkInputs = [alcotest alcotest-lwt];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "Tezos: error monad";};
}
