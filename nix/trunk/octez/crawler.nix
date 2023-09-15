{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, octez-shell-libs
}:
buildDunePackage {
  pname = "octez-crawler";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    octez-shell-libs
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: library to crawl blocks of the L1 chain";
    };
}
