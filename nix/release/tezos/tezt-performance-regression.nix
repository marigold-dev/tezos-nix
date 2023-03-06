{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezt,
  uri,
  cohttp-lwt-unix,
}:
buildDunePackage {
  pname = "tezt-performance-regression";
  inherit (tezos-stdlib) version src postPatch;

  duneVersion = "3";

  propagatedBuildInputs = [
    tezt
    uri
    cohttp-lwt-unix
  ];
}
