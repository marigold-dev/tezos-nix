{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, octez-shell-libs
, octez-l2-libs
, tezos-dac-lib
, tezos-dac-client-lib
}:
buildDunePackage {
  pname = "tezos-dac-node-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    octez-shell-libs
    octez-l2-libs
    tezos-dac-lib
    tezos-dac-client-lib
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dac-node` library";
    };
}
