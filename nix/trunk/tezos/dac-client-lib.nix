{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, octez-shell-libs
, tezos-dac-lib
}:
buildDunePackage {
  pname = "tezos-dac-client-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    octez-shell-libs
    tezos-dac-lib
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dac-client` library";
    };
}
