{
  lib,
  buildDunePackage,
  tezos-stdlib,
  data-encoding,
  lwt,
  lwt-canceler,
  tezos-lwt-result-stdlib,
  tezt,
  octez-alcotezt,
}:
buildDunePackage {
  pname = "tezos-error-monad";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-stdlib data-encoding lwt lwt-canceler tezos-lwt-result-stdlib];

  checkInputs = [
    tezt
    octez-alcotezt
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "Tezos: error monad";};
}
