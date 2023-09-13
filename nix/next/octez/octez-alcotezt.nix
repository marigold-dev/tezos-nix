{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, tezt
,
}:
buildDunePackage {
  pname = "octez-alcotezt";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezt
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Provide the interface of Alcotest for Octez, but with Tezt as backend";
    };
}
