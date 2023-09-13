{ lib
, fetchpatch
, buildDunePackage
, octez-libs
}:
buildDunePackage {
  pname = "octez-smart-rollup";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: library for Smart Rollups";
    };
}
