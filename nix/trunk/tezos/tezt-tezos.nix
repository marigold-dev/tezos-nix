{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezt,
  tezt-performance-regression,
  uri,
  hex,
  tezos-crypto-dal,
  tezos-base,
  cohttp-lwt-unix,
}:
buildDunePackage {
  pname = "tezt-tezos";
  inherit (tezos-stdlib) version src postPatch;

  duneVersion = "3";

  propagatedBuildInputs = [
    tezt
    tezt-performance-regression
    uri
    hex
    tezos-crypto-dal
    tezos-base
    cohttp-lwt-unix
  ];
}
