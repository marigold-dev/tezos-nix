{ lib
, buildDunePackage
, octez-libs
, tezt
, uri
, cohttp-lwt-unix
, hex
,
}:
buildDunePackage {
  pname = "tezt-tezos";
  inherit (octez-libs) version src;


  propagatedBuildInputs = [
    octez-libs
    tezt
    uri
    hex
    cohttp-lwt-unix
  ];
}
