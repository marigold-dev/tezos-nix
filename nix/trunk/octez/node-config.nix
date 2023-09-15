{ lib
, buildDunePackage
, octez-libs
, octez-shell-libs
}:
buildDunePackage {
  pname = "octez-node-config";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    octez-shell-libs
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: `octez-node-config` library";
    };
}
