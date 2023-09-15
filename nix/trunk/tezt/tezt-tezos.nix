{ lib
, buildDunePackage
, octez-libs
, tezt
, uri
, cohttp-lwt-unix
, hex
}:
buildDunePackage {
  pname = "tezt-tezos";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    tezt
    uri
    cohttp-lwt-unix
    hex
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez test framework based on Tezt";
    };
}
