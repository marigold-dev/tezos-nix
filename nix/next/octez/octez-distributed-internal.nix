{ lib
, fetchpatch
, buildDunePackage
, octez-libs
,
}:
buildDunePackage {
  pname = "octez-distributed-internal";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Fork of distributed. Use for Octez only";
    };
}
