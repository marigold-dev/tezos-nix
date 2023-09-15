{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, octez-shell-libs
}:
buildDunePackage {
  pname = "tezos-dac-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    octez-shell-libs
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dac` library";
    };
}
