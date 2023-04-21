{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-error-monad,
  data-encoding,
  lwt_log,
  lwt,
}:
buildDunePackage {
  pname = "tezos-event-logging";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-stdlib tezos-error-monad data-encoding lwt_log lwt];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "Tezos: event logging library";};
}
