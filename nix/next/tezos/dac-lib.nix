{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, tezos-protocol-updater
,
}:
buildDunePackage {
  pname = "tezos-dac-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-protocol-updater
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dac` library";
    };
}
