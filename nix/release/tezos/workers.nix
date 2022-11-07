{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-base-test-helpers,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-workers";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-base];

  checkInputs = [
    tezos-base-test-helpers
    alcotest-lwt
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "Tezos: worker library";};
}
