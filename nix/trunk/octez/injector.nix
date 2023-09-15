{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, logs
, octez-shell-libs
, octez-crawler
}:
buildDunePackage {
  pname = "octez-injector";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    logs
    octez-shell-libs
    octez-crawler
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: library for building injectors";
    };
}
